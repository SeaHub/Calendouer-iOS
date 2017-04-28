//
//  UserInfo.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/13.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

final class UserInfo: NSObject, NSCoding {
    var id = 0
    var name = ""
    
    var isReceiveMovie: Bool       = true
    var isReceiveReport: Bool      = true
    var isReceiveMatter: Bool      = true
    var isReceive3DayWeather: Bool = true
    var isReceiveLifeScore: Bool   = true
    
    var isCacheMovieList: Bool   = false
    var isCacheNovelList: Bool   = false
    var isCache3DayWeather: Bool = false
    var isCacheLifeScore: Bool   = false
    
    var timestamp: Int            = 0
    var weatherDetailedTimestamp  = 0
    
    var weatherMsg: Array<String>     = []
    var _3DayWeather: [WeatherObject] = []
    var lifeScore: LifeScoreObject?   = nil

    var weatherDetailedCacheExistedTime: Int {
        get {
            guard weatherDetailedTimestamp > 0 else {
                return 0
            }
            let now  = Int(Date().timeIntervalSince1970)
            let last = weatherDetailedTimestamp
            printLog(message: "weatherDetailedTimestamp 时间戳 - Now: \(now) Last: \(weatherDetailedTimestamp)")
            return now - last
        }
    }
    
    convenience init(irMovie: Bool, irReport: Bool, irMatter: Bool, ir3DWeather: Bool, irLifeScore: Bool,
                     caMovie: Bool, caNovel: Bool, ca3DayWeather: Bool, caLifeScore: Bool,
                     timestamp: Int, weatherDetailedTimestamp: Int,
                     weather: Array<String>, _3DayWeather: [WeatherObject], lifeScore: LifeScoreObject?) {
        self.init()
        self.isReceiveMovie       = irMovie
        self.isReceiveMatter      = irMatter
        self.isReceiveReport      = irReport
        self.isReceive3DayWeather = ir3DWeather
        self.isReceiveLifeScore   = irLifeScore
        
        self.isCacheMovieList   = caMovie
        self.isCacheNovelList   = caNovel
        self.isCache3DayWeather = ca3DayWeather
        self.isCacheLifeScore   = caLifeScore
        
        self.timestamp                = timestamp
        self.weatherDetailedTimestamp = weatherDetailedTimestamp
        
        self.weatherMsg     = weather
        self._3DayWeather   = _3DayWeather
        self.lifeScore      = lifeScore
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        for child in Mirror(reflecting: self).children {
            if let key = child.label {
                setValue(aDecoder.decodeObject(forKey: key), forKey: key)
            }
        }
    }
    
    func encode(with aCoder: NSCoder) {
        for child in Mirror(reflecting: self).children {
            if let key = child.label {
                aCoder.encode(value(forKey: key), forKey: key)
            }
        }
    }
}
