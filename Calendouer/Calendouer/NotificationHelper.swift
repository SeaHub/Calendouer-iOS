//
//  NotificationHelper.swift
//  Calendouer
//
//  Created by SeaHub on 2017/5/2.
//  Copyright © 2017年 Seahub. All rights reserved.
//

import Foundation
import UserNotifications

public  let k6hoursLaterIdentifier     = "action.6hoursLater"
public  let kCurrentActionIdentifier   = "action.current"
public  let kNotificationCategoryKey   = "notificationCategoryKey"
private let kOpenTypeStrKey            = "kOpenTypeKey"
private let kImageAttachmentIdentifier = "imageAttachment"

enum LocalNotificationType: String {
    case LifeScore
    case Movie
}

final class NotificationHelper: NSObject {
    /// 发送本地通知 / 更新通知
    ///
    /// - Parameters:
    ///   - title: 本地通知的名称
    ///   - body: 本地通知的内容
    ///   - type: 本地通知的类型
    ///   - timeInterval: 本地通知的延后发送时间
    ///   - isRepeated: 是否重复(若重复则发送时间需 >= 60s)
    ///   - imageURL: 可选，本地推送的图片
    public class func sendLocalNotification(title: String, body: String, type: LocalNotificationType, timeInterval: TimeInterval, isRepeated: Bool, imageURL: URL?) {
        assert(!isRepeated || (isRepeated && timeInterval >= 60), "重复时间太短")
    
        let content       = UNMutableNotificationContent()
        content.title     = title
        content.body      = body
        content.userInfo  = [kOpenTypeStrKey: type.rawValue]
        content.categoryIdentifier = "notificationCategoryKey"
        if let imageURL   = imageURL,
           let attachment = try? UNNotificationAttachment(identifier: kImageAttachmentIdentifier,
                                                           url: imageURL, options: nil) {
            content.attachments = [attachment]
        }
        
        let trigger       = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: isRepeated)
        let identifier    = type.rawValue
        let request       = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            guard error == nil else {
                printLog(message: error.debugDescription)
                return
            }
            
            printLog(message: "\(identifier) local notification send")
        }
    }
    
    /// 取消未展示的通知
    ///
    /// - Parameter types: 取消通知的类型
    public class func cancelUnshownLocalNotification(types: [LocalNotificationType]) {
        var identifiers: [String] = []
        types.forEach { type in
            identifiers.append(type.rawValue)
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    /// 移除已展示的通知
    ///
    /// - Parameter types: 移除通知的类型
    public class func removeDisplayedLocalNotification(types: [LocalNotificationType]) {
        var identifiers: [String] = []
        types.forEach { type in
            identifiers.append(type.rawValue)
        }
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: identifiers)
    }
}

extension NotificationHelper: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        guard let openTypeStr = response.notification.request.content.userInfo[kOpenTypeStrKey] as? String else {
            completionHandler()
            return
        }
        
        // TODO: 处理点入后的界面跳转
        switch openTypeStr {
        case LocalNotificationType.LifeScore.rawValue:
            printLog(message: "LifeScore Type")
        case LocalNotificationType.Movie.rawValue:
            printLog(message: "Movie Type")
        default:
            printLog(message: "Unknown Type")
        }
        
        let identifier = response.notification.request.content.categoryIdentifier
        if identifier == kNotificationCategoryKey {
            switch response.actionIdentifier {
            case k6hoursLaterIdentifier:
                printLog(message: "Send notification again")
            case kCurrentActionIdentifier:
                printLog(message: "Open App")
            default:
                printLog(message: "Unknown Type")
            }
        }
        
        completionHandler()
    }
}
