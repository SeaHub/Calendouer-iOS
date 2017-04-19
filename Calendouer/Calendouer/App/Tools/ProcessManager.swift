//
//  ProcessManager.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/8.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProcessManager: NSObject {
    
    public func GetWeather(Switch authority: Bool, latitude: CGFloat, longitude: CGFloat, handle: @escaping (_ weather: WeatherObject) -> Void) {
        let url: String = "https://api.thinkpage.cn/v3/weather/daily.json?key=c3zfxqulwe5jzete&location=\(latitude):\(longitude)&language=zh-Hans&unit=c"
        Alamofire.request(url).responseJSON { response in
            let json = JSON(response.result.value!)
            var dataDic: [String: String] = [:]
            dataDic["name"]                 = json["results"][0]["location"]["name"].stringValue
            dataDic["path"]                 = json["results"][0]["location"]["path"].stringValue
            dataDic["id"]                   = json["results"][0]["location"]["id"].stringValue
            dataDic["country"]              = json["results"][0]["location"]["country"].stringValue
            dataDic["timezone"]             = json["results"][0]["location"]["timezone"].stringValue
            dataDic["timezone_offset"]      = json["results"][0]["location"]["timezone_offset"].stringValue
            dataDic["date"]                 = json["results"][0]["daily"][0]["date"].stringValue
            dataDic["text_day"]             = json["results"][0]["daily"][0]["text_day"].stringValue
            dataDic["code_day"]             = json["results"][0]["daily"][0]["code_day"].stringValue
            dataDic["text_night"]           = json["results"][0]["daily"][0]["text_night"].stringValue
            dataDic["code_night"]           = json["results"][0]["daily"][0]["code_night"].stringValue
            dataDic["high"]                 = json["results"][0]["daily"][0]["high"].stringValue
            dataDic["low"]                  = json["results"][0]["daily"][0]["low"].stringValue
            dataDic["precip"]               = json["results"][0]["daily"][0]["precip"].stringValue
            dataDic["wind_direction"]       = json["results"][0]["daily"][0]["wind_direction"].stringValue
            dataDic["wind_direction_degree"] = json["results"][0]["daily"][0]["wind_direction_degree"].stringValue
            dataDic["wind_speed"]           = json["results"][0]["daily"][0]["wind_speed"].stringValue
            dataDic["wind_scale"]           = json["results"][0]["daily"][0]["wind_scale"].stringValue
            dataDic["last_update"]          = json["results"][0]["last_update"].stringValue
            
            let weather: WeatherObject = WeatherObject(Dictionary: dataDic)
            handle(weather)
        }
    }
    
    public func GetDay(Switch authority: Bool, handle: @escaping (_ day: DayObject) -> Void) {
        let dayObject: DayObject = DayObject()
        handle(dayObject)
    }
    
    public func GetMovie(Switch authority: Bool, handle: @escaping (_ movie: MovieObject) -> Void) {
        let top250Url = "https://api.douban.com/v2/movie/top250"
        Alamofire.request(top250Url).responseJSON { (response) in
            let json = JSON(response.result.value!)
            let index = Int(arc4random() % 20)
            var dataDic: [String: String] = [: ]
            dataDic["id"]                   = json["subjects"][index]["id"].stringValue
            dataDic["images"]               = json["subjects"][index]["images"]["large"].stringValue
            dataDic["title"]                = json["subjects"][index]["title"].stringValue
            
            let getMovieUrl = "https://api.douban.com/v2/movie/subject/\(dataDic["id"]! as String)"
            Alamofire.request(getMovieUrl).responseJSON(completionHandler: { (response) in
                let json_movie = JSON(response.result.value!)
                dataDic["rating"]               = "\(json_movie["rating"]["average"].floatValue)"
                dataDic["original_title"]       = json_movie["title"].stringValue
                dataDic["alt_title"]            = json_movie["alt_title"].stringValue
                dataDic["summary"]              = json_movie["summary"].stringValue
                dataDic["mobile_link"]          = json_movie["mobile_link"].stringValue
                dataDic["alt"]                  = json_movie["alt"].stringValue
                dataDic["year"]                 = json_movie["year"].stringValue
                dataDic["director"]             = json_movie["directors"][0]["name"].stringValue
                dataDic["id"]                   = json_movie["id"].stringValue
                
                let movie: MovieObject = MovieObject(Dictionary: dataDic)
                handle(movie)
            })
        }
    }
}

