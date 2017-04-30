//
//  WidgetHelper.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/29.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

let widgetHelper = WidgetHelper.shared

class WidgetHelper: NSObject {
    static let shared = WidgetHelper()
    let dataSharer = UserDefaults(suiteName: "group.desgard.calendouer")
    
    public func shareDegree(low: String, high: String) {
        dataSharer?.set("\(low)°C - \(high)°C", forKey: "degree")
        synchronize()
    }
    
    public func shareStatus(text_day: String, text_nigth: String) {
        dataSharer?.set("\(text_day)转\(text_nigth)", forKey: "status")
        synchronize()
    }
    
    public func shareCity(city: String) {
        dataSharer?.set(city, forKey: "city")
        synchronize()
    }
    
    public func shareWeatherImg(image: String) {
        dataSharer?.set(image, forKey: "weather-img")
        synchronize()
    }
    
    public func shareAirQlty(air: String) {
        dataSharer?.set("空气质量：\(air)", forKey: "air-qlty")
        synchronize()
    }
    
    public func shareAirMsgs(aqi: String, pm25: String) {
        dataSharer?.set("AQI: \(aqi)   PM2.5: \(pm25)", forKey: "air-msg")
        synchronize()
    }
    
    public func shareLifeScoreImage(image: String) {
        // Description: 传入 image 名称
        dataSharer?.set(image, forKey: "life-score-img")
        synchronize()
    }
    
    public func shareLifeScoreMsg(type: String, state: String) {
        // Description: 传入生活指数类（中文），生活指数状态（中文）
        // Sample: 空气质量很差
        dataSharer?.set("\(type)\(state)", forKey: "life-score-msg")
        synchronize()
    }
    
    public func shareLifeScoreDetail(text: String) {
        // Description: 传入 txt 信息
        dataSharer?.set(text, forKey: "life-score-detail")
        synchronize()
    }
    
    private func synchronize() {
        dataSharer?.synchronize()
    }
    
}
