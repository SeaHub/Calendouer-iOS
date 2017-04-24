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
    
    // 获取当日天气
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
    
    // 获取三日天气
    public func Get3DaysWeather(Switch authority: Bool, latitude: CGFloat, longitude: CGFloat, handle: @escaping (_ weather: [WeatherObject]) -> Void) {
        let url: String = "https://api.seniverse.com/v3/weather/daily.json?key=c3zfxqulwe5jzete&location=\(latitude):\(longitude)&language=zh-Hans&unit=c&start=-1&days=5"
        Alamofire.request(url).responseJSON { response in
            let json = JSON(response.result.value!)
            var res: [WeatherObject] = []
            let location = json["results"][0]["location"]["name"].stringValue
            let update_time = json["results"][0]["last_update"].stringValue
            let datas = json["results"][0]["daily"].arrayValue
            for data in datas {
                let metaData: JSON = data
                let weather: WeatherObject = WeatherObject(Dictionary: [:])
                weather.date = metaData["date"].stringValue
                weather.text_day = metaData["text_day"].stringValue
                weather.code_day = metaData["code_day"].stringValue
                weather.text_night = metaData["text_night"].stringValue
                weather.code_night = metaData["code_night"].stringValue
                weather.wind_direction = metaData["wind_direction"].stringValue
                weather.wind_scale = metaData["wind_scale"].stringValue
                weather.high = metaData["high"].stringValue
                weather.low = metaData["low"].stringValue
                weather.city = location
                weather.last_update = update_time
                res.append(weather)
            }
            handle(res)
        }
    }
    
    // 根据坐标获取空气质量
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
    
    // 根据城市名称获取空气质量
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
    
    // 获取当日生活指数
    public func GetLifeScore(Switch authority: Bool, city: String, handle: @escaping (_ air: LifeScoreObject) -> Void) {
        let url = "https://free-api.heweather.com/v5/suggestion?city=\(city)&key=c3acec2e21754c9585d6e7db857a5999"
        let urln = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        Alamofire.request(urln).responseJSON { response in
            let json = JSON(response.result.value!)
            let lifeScore = LifeScoreObject()
            lifeScore.city = json["HeWeather5"][0]["basic"]["city"].stringValue
            lifeScore.air_brf = json["HeWeather5"][0]["suggestion"]["air"]["brf"].stringValue
            lifeScore.air_txt = json["HeWeather5"][0]["suggestion"]["air"]["txt"].stringValue
            lifeScore.comf_brf = json["HeWeather5"][0]["suggestion"]["comf"]["brf"].stringValue
            lifeScore.comf_txt = json["HeWeather5"][0]["suggestion"]["comf"]["txt"].stringValue
            lifeScore.cw_brf = json["HeWeather5"][0]["suggestion"]["cw"]["brf"].stringValue
            lifeScore.cw_txt = json["HeWeather5"][0]["suggestion"]["cw"]["txt"].stringValue
            lifeScore.drsg_brf = json["HeWeather5"][0]["suggestion"]["drsg"]["brf"].stringValue
            lifeScore.drsg_txt = json["HeWeather5"][0]["suggestion"]["drsg"]["txt"].stringValue
            lifeScore.flu_brf = json["heweather5"][0]["suggestion"]["flu"]["brf"].stringValue
            lifeScore.flu_txt = json["HeWeather5"][0]["suggestion"]["flu"]["txt"].stringValue
            lifeScore.sport_brf = json["HeWeather5"][0]["suggestion"]["sport"]["brf"].stringValue
            lifeScore.sport_txt = json["HeWeather5"][0]["suggestion"]["sport"]["txt"].stringValue
            lifeScore.trav_brf = json["HeWeather5"][0]["suggestion"]["trav"]["brf"].stringValue
            lifeScore.trav_txt = json["HeWeather5"][0]["suggestion"]["trav"]["txt"].stringValue
            lifeScore.uv_brf = json["HeWeather5"][0]["suggestion"]["uv"]["brf"].stringValue
            lifeScore.uv_txt = json["HeWeather5"][0]["suggestion"]["uv"]["txt"].stringValue
            
            handle(lifeScore)
        }
    }
    
    // 获取当日信息
    public func GetDay(Switch authority: Bool, handle: @escaping (_ day: DayObject) -> Void) {
        let dayObject: DayObject = DayObject()
        handle(dayObject)
    }
    
    // 获取随机电影
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
    
    // 缓存电影数据
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
    
    // 获取电影数据
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
                    var dataDic: [String: Any] = [: ]
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
                    dataDic["countries"]            = self.jsonToArr(jsons: json_movie["countries"].arrayValue)
                    dataDic["genres"]               = self.jsonToArr(jsons: json_movie["genres"].arrayValue)
                    dataDic["ratings_count"]        = json_movie["ratings_count"].intValue
                    
                    let movie: MovieObject = MovieObject(Dictionary: dataDic)
                    DataBase.addMovieToDB(movie: movie, today: today.getDayToString())
                    handle(movie)
                })
            }
        }
    }
    
    // Change
    private func jsonToArr(jsons: [JSON]) -> [String] {
        var arr: [String] = []
        for json in jsons {
            arr.append(json.stringValue)
        }
        return arr
    }
}

