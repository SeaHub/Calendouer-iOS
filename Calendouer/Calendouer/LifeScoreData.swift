//
//  LifeScoreData.swift
//  Calendouer
//
//  Created by SeaHub on 2017/4/26.
//  Copyright © 2017年 Seahub. All rights reserved.
//

import Foundation
import RealmSwift

class LifeScoreData: Object {
    dynamic var city           = ""
    dynamic var air_brf        = ""
    dynamic var air_txt        = ""
    dynamic var comf_brf       = ""
    dynamic var comf_txt       = ""
    dynamic var cw_brf         = ""
    dynamic var cw_txt         = ""
    dynamic var drsg_brf       = ""
    dynamic var drsg_txt       = ""
    dynamic var flu_brf        = ""
    dynamic var flu_txt        = ""
    dynamic var sport_brf      = ""
    dynamic var sport_txt      = ""
    dynamic var trav_brf       = ""
    dynamic var trav_txt       = ""
    dynamic var uv_brf         = ""
    dynamic var uv_txt         = ""
    
    dynamic var is_appeared         = false
    dynamic var appear_day: String? = nil
    dynamic var id                  = ""
    
    public func toObject() -> LifeScoreObject {
        let lifeScore          = LifeScoreObject()
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
}

class LifeScoreBasicData: Object {
    dynamic var lifeScore_id  = ""
    dynamic var is_appeared   = false
}
