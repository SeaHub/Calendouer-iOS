//
//  UIAlertController+Extensions.swift
//  Calendouer
//
//  Created by SeaHub on 2017/5/2.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    @available(iOS 8.0, *)
    class func showCancelAlert(title: String, msg: String, cancelBtnTitle: String, cancelBlock: ((UIAlertAction) -> Void)?) {
        printLog(message: "Cancel alert showing with title:\(title) and msg:\(msg)")
        let alertController: UIAlertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction: UIAlertAction        = UIAlertAction(title: cancelBtnTitle, style: .cancel, handler: cancelBlock)
        
        alertController.addAction(cancelAction)
        
        let rootVC  = UIApplication.shared.keyWindow?.rootViewController
        rootVC?.present(alertController, animated: true, completion: nil)
    }
}
