//
//  MovieData.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/18.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import Foundation
import RealmSwift

class MovieData: Object {
    dynamic var movie_id = ""
    dynamic var title = ""
    dynamic var rating = ""
    dynamic var year = ""
    dynamic var images = ""
    dynamic var summary = ""
    dynamic var original_title = ""
    dynamic var genres = ""
    dynamic var director = ""
    
    dynamic var is_appeared = false
    dynamic var appear_day: String? = nil
}
