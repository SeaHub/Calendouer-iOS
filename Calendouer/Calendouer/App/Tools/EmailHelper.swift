//
//  EmailHelper.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/28.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import MessageUI

let emailHelper = EmailHelper.shared

class EmailHelper: NSObject {
    static let shared = EmailHelper()
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerViewController = MFMailComposeViewController()
        
        mailComposerViewController.mailComposeDelegate = self
        mailComposerViewController.setToRecipients(["gua@desgard.com"])
        mailComposerViewController.setSubject("CALENDOUER - 意见反馈")
        mailComposerViewController.setMessageBody(addDeviceMsgs(), isHTML: false)
        mailComposerViewController.navigationBar.tintColor = .white
        
        return mailComposerViewController
    }
    
    private func addDeviceMsgs() -> String {
        //获取系统版本号
        let systemVersion = UIDevice.current.systemVersion
        //获取设备的型号
        let deviceModel = UIDevice.current.modelName
        return "\n\n\n\n系统版本：\(systemVersion)\n设备型号：\(deviceModel)"
    }
    
    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func showSendmailErrorAlert() {
        // iOS 7 及以下弹窗提示
        guard #available(iOS 8, *) else {
            let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
            return
        }
        
        // iOS 7+ 自动弹窗，无需处理
        printLog(message: "Could Not Send Email")
    }
}

extension EmailHelper: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
        case .cancelled:
            fallthrough
        case .sent:
            printLog(message: "邮件发送成功")
            fallthrough
        case .saved:
            fallthrough
        case .failed:
            controller.dismiss(animated: true, completion: {})
            break
        }
    }
}
