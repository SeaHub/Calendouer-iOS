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
    
    public func toObject() -> MovieObject {
        let movie: MovieObject = MovieObject(Dictionary: [:])
        movie.id = self.movie_id
        movie.title = self.title
        movie.rating = self.rating
        movie.year = self.year
        movie.images = self.images
        movie.summary = self.summary
        movie.original_title = self.original_title
        movie.genres = self.genres
        movie.director = self.genres
        return movie
    }
}

class MovieBasicData: Object {
    dynamic var movie_id = ""
    dynamic var is_appeared = false
}
