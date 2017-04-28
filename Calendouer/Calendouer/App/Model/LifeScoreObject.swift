//
//  LifeScoreObject.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/24.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class LifeScoreObject: NSObject, NSCoding {
    var city = ""
    // 空气指数
    var air_brf = ""
    var air_txt = ""
    // 舒适度指数
    var comf_brf = ""
    var comf_txt = ""
    // 穿衣指数
    var drsg_brf = ""
    var drsg_txt = ""
    // 感冒指数
    var flu_brf = ""
    var flu_txt = ""
    // 运动指数
    var sport_brf = ""
    var sport_txt = ""
    // 旅游指数
    var trav_brf = ""
    var trav_txt = ""
    // 紫外线指数
    var uv_brf = ""
    var uv_txt = ""
    // 洗车指数
    var cw_brf = ""
    var cw_txt = "'"
    // 唯一标示，用于数据库
    var id = ""
    
    public func toData() -> LifeScoreData {
        let lifeScore          = LifeScoreData()
        lifeScore.city         = city
        lifeScore.air_brf      = air_brf
        lifeScore.air_txt      = air_txt
        lifeScore.comf_brf     = comf_brf
        lifeScore.comf_txt     = comf_txt
        lifeScore.cw_brf       = cw_brf
        lifeScore.cw_txt       = cw_txt
        lifeScore.drsg_brf     = drsg_brf
        lifeScore.drsg_txt     = drsg_txt
        lifeScore.flu_brf      = flu_brf
        lifeScore.flu_txt      = flu_txt
        lifeScore.sport_brf    = sport_brf
        lifeScore.sport_txt    = sport_txt
        lifeScore.trav_brf     = trav_brf
        lifeScore.trav_txt     = trav_txt
        lifeScore.uv_brf       = uv_brf
        lifeScore.uv_txt       = uv_txt
        lifeScore.id           = id
        
        return lifeScore
    }
    
    required override init() {
    }
    
    // MARK: - NSCoding -
    private struct LifeScoreObjectCodingKey {
        static let kCodingCity           = "city"
        static let kCodingAir_brf        = "air_brf"
        static let kCodingAir_txt        = "air_txt"
        static let kCodingComf_brf       = "comf_brf"
        static let kCodingComf_txt       = "comf_txt"
        static let kCodingDrsg_brf       = "drsg_brf"
        static let kCodingDrsg_txt       = "drsg_txt"
        static let kCodingFlu_brf        = "flu_brf"
        static let kCodingFlu_txt        = "flu_txt"
        static let kCodingSport_brf      = "sport_brf"
        static let kCodingSport_txt      = "sport_txt"
        static let kCodingTrav_brf       = "trav_brf"
        static let kCodingTrav_txt       = "trav_txt"
        static let kCodingUv_brf         = "uv_brf"
        static let kCodingUv_txt         = "uv_txt"
        static let kCodingCw_brf         = "cw_brf"
        static let kCodingCw_txt         = "cw_txt"
        static let kCodingID             = "id"
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.city           = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingCity) as! String
        self.air_brf        = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingAir_brf) as! String
        self.air_txt        = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingAir_txt) as! String
        self.comf_brf       = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingComf_brf) as! String
        self.comf_txt       = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingComf_txt) as! String
        self.drsg_brf       = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingDrsg_brf) as! String
        self.drsg_txt       = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingDrsg_txt) as! String
        self.flu_brf        = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingFlu_brf) as! String
        self.flu_txt        = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingFlu_txt) as! String
        self.sport_brf      = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingSport_brf) as! String
        self.sport_txt      = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingSport_txt) as! String
        self.trav_brf       = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingTrav_brf) as! String
        self.trav_txt       = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingTrav_txt) as! String
        self.uv_brf         = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingUv_brf) as! String
        self.uv_txt         = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingUv_txt) as! String
        self.cw_brf         = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingCw_brf) as! String
        self.cw_txt         = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingCw_txt) as! String
        self.id             = aDecoder.decodeObject(forKey: LifeScoreObjectCodingKey.kCodingID) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.city,      forKey: LifeScoreObjectCodingKey.kCodingCity)
        aCoder.encode(self.air_brf,   forKey: LifeScoreObjectCodingKey.kCodingAir_brf)
        aCoder.encode(self.air_txt,   forKey: LifeScoreObjectCodingKey.kCodingAir_txt)
        aCoder.encode(self.comf_brf,  forKey: LifeScoreObjectCodingKey.kCodingComf_brf)
        aCoder.encode(self.comf_txt,  forKey: LifeScoreObjectCodingKey.kCodingComf_txt)
        aCoder.encode(self.drsg_brf,  forKey: LifeScoreObjectCodingKey.kCodingDrsg_brf)
        aCoder.encode(self.drsg_txt,  forKey: LifeScoreObjectCodingKey.kCodingDrsg_txt)
        aCoder.encode(self.flu_brf,   forKey: LifeScoreObjectCodingKey.kCodingFlu_brf)
        aCoder.encode(self.flu_txt,   forKey: LifeScoreObjectCodingKey.kCodingFlu_txt)
        aCoder.encode(self.sport_brf, forKey: LifeScoreObjectCodingKey.kCodingSport_brf)
        aCoder.encode(self.sport_txt, forKey: LifeScoreObjectCodingKey.kCodingSport_txt)
        aCoder.encode(self.trav_brf,  forKey: LifeScoreObjectCodingKey.kCodingTrav_brf)
        aCoder.encode(self.trav_txt,  forKey: LifeScoreObjectCodingKey.kCodingTrav_txt)
        aCoder.encode(self.uv_brf,    forKey: LifeScoreObjectCodingKey.kCodingUv_brf)
        aCoder.encode(self.uv_txt,    forKey: LifeScoreObjectCodingKey.kCodingUv_txt)
        aCoder.encode(self.cw_brf,    forKey: LifeScoreObjectCodingKey.kCodingCw_brf)
        aCoder.encode(self.cw_txt,    forKey: LifeScoreObjectCodingKey.kCodingCw_txt)
        aCoder.encode(self.id ,       forKey: LifeScoreObjectCodingKey.kCodingID)
    }
}
