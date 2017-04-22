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
    
    public func GetAir(Switch authority: Bool, latitude: CGFloat, longitude: CGFloat, handle: @escaping (_ air: AirObject) -> Void) {
        let url = "https://free-api.heweather.com/v5/weather?city=\(longitude),\(latitude)&key=c3acec2e21754c9585d6e7db857a5999"
        Alamofire.request(url).responseJSON { response in
            let json = JSON(response.result.value!)
            let air = AirObject()
            air.aqi = json["HeWeather5"][0]["aqi"]["city"]["aqi"].stringValue
            air.co = json["HeWeather5"][0]["aqi"]["city"]["co"].stringValue
            air.no2 = json["HeWeather5"][0]["aqi"]["city"]["no2"].stringValue
            air.o3 = json["HeWeather5"][0]["aqi"]["city"]["o3"].stringValue
            air.pm10 = json["HeWeather5"][0]["aqi"]["city"]["pm10"].stringValue
            air.pm25 = json["HeWeather5"][0]["aqi"]["city"]["pm25"].stringValue
            air.qlty = json["HeWeather5"][0]["aqi"]["city"]["qlty"].stringValue
            air.so2 = json["HeWeather5"][0]["aqi"]["city"]["so2"].stringValue
            air.txt = json["HeWeather5"][0]["suggestion"]["air"]["txt"].stringValue
            
            handle(air)
        }
    }
    
    public func GetAir(Switch authority: Bool, city: String, handle: @escaping (_ air: AirObject) -> Void) {
        let url = "https://free-api.heweather.com/v5/weather?city=\(city)&key=c3acec2e21754c9585d6e7db857a5999"
        let urln = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        Alamofire.request(urln).responseJSON { response in
            let json = JSON(response.result.value!)
            let air = AirObject()
            air.aqi = json["HeWeather5"][0]["aqi"]["city"]["aqi"].stringValue
            air.co = json["HeWeather5"][0]["aqi"]["city"]["co"].stringValue
            air.no2 = json["HeWeather5"][0]["aqi"]["city"]["no2"].stringValue
            air.o3 = json["HeWeather5"][0]["aqi"]["city"]["o3"].stringValue
            air.pm10 = json["HeWeather5"][0]["aqi"]["city"]["pm10"].stringValue
            air.pm25 = json["HeWeather5"][0]["aqi"]["city"]["pm25"].stringValue
            air.qlty = json["HeWeather5"][0]["aqi"]["city"]["qlty"].stringValue
            air.so2 = json["HeWeather5"][0]["aqi"]["city"]["so2"].stringValue
            air.txt = json["HeWeather5"][0]["suggestion"]["air"]["txt"].stringValue
            
            handle(air)
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
    
    public func cacheMovies(Switch authority: Bool, handle: @escaping (_ status: Bool) -> Void) {
        let top250Url = "https://api.douban.com/v2/movie/top250?start=0&count=250"
        Alamofire.request(top250Url).responseJSON { (response) in
            let json = JSON(response.result.value ?? "")
            for index in 0...249 {
                let movie_id = json["subjects"][index]["id"].stringValue
                if movie_id != "" {
                    DataBase.addMovieBasicToDB(movie_id: movie_id)
                }
            }
            handle(true)
        }
    }
    
    public func getMovieFromCache(Switch authority: Bool, handle: @escaping (_ movie: MovieObject) -> Void) {
        let today = DayObject()
        let todayMovie = DataBase.getTodayMovieFromDB(appear_day: today.getDayToString())
        if todayMovie.id != "" {
            handle(todayMovie)
        } else {
            let todayMovieBasic = DataBase.popMovieBasicFromDB()
            if todayMovieBasic.movie_id != "" {
                let getMovieUrl = "https://api.douban.com/v2/movie/subject/\(todayMovieBasic.movie_id)"
                Alamofire.request(getMovieUrl).responseJSON(completionHandler: { (response) in
                    let json_movie = JSON(response.result.value!)
                    var dataDic: [String: String] = [: ]
                    dataDic["rating"]               = "\(json_movie["rating"]["average"].floatValue)"
                    dataDic["original_title"]       = json_movie["title"].stringValue
                    dataDic["alt_title"]            = json_movie["alt_title"].stringValue
                    dataDic["summary"]              = json_movie["summary"].stringValue
                    dataDic["mobile_link"]          = json_movie["mobile_link"].stringValue
                    dataDic["alt"]                  = json_movie["alt"].stringValue
                    dataDic["year"]                 = json_movie["year"].stringValue
                    dataDic["director"]             = json_movie["directors"][0]["name"].stringValue
                    dataDic["id"]                   = json_movie["id"].stringValue
                    dataDic["images"]               = json_movie["images"]["large"].stringValue
                    dataDic["title"]                = json_movie["title"].stringValue
                    
                    let movie: MovieObject = MovieObject(Dictionary: dataDic)
                    DataBase.addMovieToDB(movie: movie, today: today.getDayToString())
                    handle(movie)
                })
            }
        }
    }
}

