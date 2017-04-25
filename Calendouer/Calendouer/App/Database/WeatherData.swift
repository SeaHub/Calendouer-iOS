//
//  WeatherData.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/23.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherData: Object {
    dynamic var date           = ""
    dynamic var text_day       = ""
    dynamic var text_night     = ""
    dynamic var code_day       = ""
    dynamic var code_night     = ""
    dynamic var wind_direction = ""
    dynamic var wind_scale     = ""
    dynamic var location       = ""
    dynamic var last_update    = ""
    
    public func toObject() -> WeatherObject {
        let weather: WeatherObject = WeatherObject(Dictionary: [:])
        weather.date           = date
        weather.text_day       = text_day
        weather.text_night     = text_night
        weather.code_day       = code_day
        weather.code_night     = code_night
        weather.wind_direction = wind_direction
        weather.wind_scale     = wind_scale
        weather.city           = location
        weather.last_update    = last_update
        
        return weather
    }
}

class WeatherBasicData: Object {
    dynamic var weather_id  = ""
    dynamic var is_appeared = false
}
