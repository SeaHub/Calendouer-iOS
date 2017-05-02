//
//  DispatchQueue+Extensions.swift
//  Calendouer
//
//  Created by SeaHub on 2017/5/2.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import Foundation
extension DispatchQueue {
    private static var _onceTracker = [String]()
    
    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self);
        defer {
            objc_sync_exit(self)
        }
        
        guard !_onceTracker.contains(token) else {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
