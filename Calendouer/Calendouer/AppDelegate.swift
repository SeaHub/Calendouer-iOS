//
//  AppDelegate.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/2.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let notificationHelper: NotificationHelper = NotificationHelper()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navbarFont = UIFont(name: "Ubuntu-Light", size: 17) ?? UIFont.systemFont(ofSize: 17)
        let barbuttonFont = UIFont(name: "Ubuntu-Light", size: 15) ?? UIFont.systemFont(ofSize: 15)
        
        UINavigationBar.appearance().barTintColor = DouGreen
        UINavigationBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: barbuttonFont, NSForegroundColorAttributeName: UIColor.white], for: UIControlState.normal)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        
        window?.makeKeyAndVisible()
        let launchAnimation = LaunchAnimationView()
        self.window?.addSubview(launchAnimation)
        launchAnimation.animationBegin()
        
        self.configureNotification()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print("widget")
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Notification -
    private func configureNotification() {
        self.registerNotificationCategory()
        UNUserNotificationCenter.current().delegate = self.notificationHelper
        let isNotificationAlertViewControllerShown  = "isNotificationAlertViewControllerShown"
        guard UserDefaults.standard.object(forKey: isNotificationAlertViewControllerShown) == nil
            || UserDefaults.standard.object(forKey: isNotificationAlertViewControllerShown) as! Bool == false else {
            return
        }
        
        UIAlertController.showCancelAlert(title: "提示", msg: "豆瓣日历接下来将请求您的授权，以通知您电影与天气方面的变化", cancelBtnTitle: "我知道了") { _ in
            UserDefaults.standard.set(true, forKey: isNotificationAlertViewControllerShown)
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, error) in
                guard isGranted && error == nil else {
                    printLog(message: "通知中心 - 用户不同意授权")
                    return
                }
                
                // 远程推送 - 需推送服务器
                // UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    private func registerNotificationCategory() {
        let category: UNNotificationCategory = {
            let openAppAction      = UNNotificationAction(
                identifier: kCurrentActionIdentifier,
                title: "打开应用",
                options: [.foreground])
            
            let _6hoursLaterAction  = UNNotificationAction(
                identifier: k6hoursLaterIdentifier,
                title: "6小时后提醒",
                options: [.destructive])
            
            return UNNotificationCategory(identifier:kNotificationCategoryKey,
                                          actions: [openAppAction, _6hoursLaterAction],
                                          intentIdentifiers: [],
                                          options: [.customDismissAction])
        }()
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    // 远程推送 - 需推送服务器
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let token = deviceToken.base64EncodedString()
//        printLog(message: "Remote notification token is \(token)")

//      JSON Format
//
//        {
//            "aps":{
//                "alert":{
//                    "title":"I am title",
//                    "subtitle":"I am subtitle",
//                    "body":"I am body"
//                },
//                "sound":"default",
//                "badge":1
//            }
//        }
//    }
}

