//
//  BlankCardObject.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/20.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class BlankCardObject: NSObject {
    enum cardType {
        case none
        case movie
        case novel
    }
    
    var cardType: cardType = .none
    
    init(type: cardType) {
        super.init()
        self.cardType = type
    }
}
