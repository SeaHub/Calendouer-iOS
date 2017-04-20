//
//  DayObject.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/10.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit


class DayObject: NSObject {
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var week: Int = 0
    var hour: Int = 0
    var luner_year: Int = 0
    var luner_month: Int = 0
    var luner_day: Int = 0
    
    override init() {
        super.init()
        var calendar: Calendar = Calendar(identifier: .gregorian)
        let date: Date = Date()
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
        week = calendar.component(.weekday, from: date)
        hour = calendar.component(.hour, from: date)
        
        calendar = Calendar(identifier: .chinese)
        luner_year = calendar.component(.year, from: date)
        luner_month = calendar.component(.month, from: date)
        luner_day = calendar.component(.day, from: date)
    }
    
    public func getLunerSpecialDate(year: Int, month: Int, day: Int) -> String {
        let chineseDays = [
            "小寒", "大寒", "立春", "雨水", "惊蛰", "春分",
            "清明", "谷雨", "立夏", "小满", "芒种", "夏至",
            "小暑", "大暑", "立秋", "处暑", "白露", "秋分",
            "寒露", "霜降", "立冬", "小雪", "大雪", "冬至",
        ]
        let arrayIndex = (year - START_YEAR) * 12 + month - 1
        let flag = FOR_LUNER_ARRAY[arrayIndex]
        var lunerDay = 0
        if day < 15 {
            lunerDay = 15 - ((flag >> 4) & 0x0f)
        } else {
            lunerDay = ((flag) & 0x0f) + 15
        }
        var index = -1
        if (day == lunerDay) {
            index = (month - 1) * 2 + (day > 15 ? 1 : 0)
        }
        if (index >= 0 && index < chineseDays.count) {
            return chineseDays[index]
        } else {
            return ""
        }
    }
    
    public func getMonth() -> String {
        let chineseMonth = [
            "一月", "二月", "三月", "四月",
            "五月", "六月", "七月", "八月",
            "九月", "十月", "十一月", "十二月",
        ]
        return chineseMonth[self.month - 1]
    }
    
    public func getWeekDay() -> String {
        let weekDay = [
            "星期天", "星期一", "星期二",
            "星期三", "星期四", "星期五",
            "星期六"
        ]
        return weekDay[self.week - 1]
    }
    
    public func getLunnerDay() -> String {
        let chineseLunnerMonth = [
            "正月", "二月", "三月", "四月",
            "五月", "六月", "七月", "八月",
            "九月", "十月", "冬月", "腊月",
        ]
        let chineseLunnerDay = [
            "初一", "初二", "初三", "初四", "初五",
            "初六", "初七", "初八", "初九", "初十",
            "十一", "十二", "十三", "十四", "十五",
            "十六", "十七", "十八", "十九", "廿十",
            "廿一", "廿二", "廿三", "廿四", "廿五",
            "廿六", "廿七", "廿八", "廿九", "三十",
        ]
        return "农历\(chineseLunnerMonth[self.luner_month - 1])\(chineseLunnerDay[self.luner_day - 1])"
    }
    
    public func getDay() -> String {
        return "\(self.day)"
    }
    
    public func getDayToString() -> String {
        var mm = "\(self.month)"
        var dd = "\(self.day)"
        if mm.length == 1 {
            mm = "0\(self.month)"
        }
        if dd.length == 1 {
            dd = "0\(self.day)"
        }
        return "\(self.year)\(self.month)\(self.day)"
    }
}
