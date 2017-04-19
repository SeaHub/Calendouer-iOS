//
//  MovieObject.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/8.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class MovieObject: NSObject {
    var rating: String = ""
    var reviews_count: Int = 0
    var wish_count: Int = 0
    var douban_site: String = ""
    var year: String = ""
    var images: String = ""
    var alt: String = ""
    var id: String = ""
    var mobile_url: String = ""
    var title: String = ""
    var do_count: Int = 0
    var share_url: String = ""
    var seasons_count: Int = 0
    var schedule_url: String = ""
    var episodes_count: Int = 0
    var countries: String = ""
    var genres: String = ""
    var collect_count: Int = 0
    var original_title: String = ""
    var summary: String = ""
    var subtype: String = ""
    var comments_count: Int = 0
    var ratings_count: Int = 0
    var aka: String = ""
    var alt_title: String = ""
    var director: String = ""
    
    init(Dictionary dic: [String: Any]) {
        if let rating = dic["rating"] {
            self.rating = rating as! String
        }
        if let reviews_count = dic["reviews_count"] {
            self.reviews_count = reviews_count as! Int
        }
        if let wish_count = dic["wish_count"] {
            self.wish_count = wish_count as! Int
        }
        if let douban_site = dic["douban_site"] {
            self.douban_site = douban_site as! String
        }
        if let year = dic["year"] {
            self.year = year as! String
        }
        if let images = dic["images"] {
            self.images = images as! String
        }
        if let alt = dic["alt"] {
            self.alt = alt as! String
        }
        if let id = dic["id"] {
            self.id = id as! String
        }
        if let mobile_url = dic["mobile_url"] {
            self.mobile_url = mobile_url as! String
        }
        if let title = dic["title"] {
            self.title = title as! String
        }
        if let do_count = dic["do_count"] {
            self.do_count = do_count as! Int
        }
        if let share_url = dic["share_url"] {
            self.share_url = share_url as! String
        }
        if let seasons_count = dic["seasons_count"] {
            self.seasons_count = seasons_count as! Int
        }
        if let schedule_url = dic["schedule_url"] {
            self.schedule_url = schedule_url as! String
        }
        if let episodes_count = dic["episodes_count"] {
            self.episodes_count = episodes_count as! Int
        }
        if let countries = dic["countries"] {
            self.countries = countries as! String
        }
        if let genres = dic["genres"] {
            self.genres = genres as! String
        }
        if let collect_count = dic["collect_count"] {
            self.collect_count = collect_count as! Int
        }
        if let original_title = dic["original_title"] {
            self.original_title = original_title as! String
        }
        if let summary = dic["summary"] {
            self.summary = summary as! String
        }
        if let subtype = dic["subtype"] {
            self.subtype = subtype as! String
        }
        if let comments_count = dic["comments_count"] {
            self.comments_count = comments_count as! Int
        }
        if let ratings_count = dic["ratings_count"] {
            self.ratings_count = ratings_count as! Int
        }
        if let aka = dic["aka"] {
            self.aka = aka as! String
        }
        if let alt_title = dic["alt_title"] {
            self.alt_title = alt_title as! String
        }
        if let director = dic["director"] {
            self.director = director as! String
        }
    }
}
