//
//  DatabaseManager.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/19.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit
import RealmSwift

let realm = try! Realm()
let DataBase = DatabaseManager.shared

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    public func addMovieToDB(movie: MovieObject, today: String) {
        let movieData = MovieData()
        movieData.title = movie.title
        movieData.rating = movie.rating
        movieData.year = movie.year
        movieData.images = movie.images
        movieData.summary = movie.summary
        movieData.original_title = movie.original_title
        movieData.genres = movie.genres
        movieData.director = movie.director
        movieData.movie_id = movie.id
        
        movieData.appear_day = today
        
        try! realm.write {
            realm.add(movieData)
        }
    }
    
    public func addMovieBasicToDB(movie_id: String) {
        let movieBasicData = MovieBasicData()
        movieBasicData.movie_id = movie_id
        
        try! realm.write {
            realm.add(movieBasicData)
        }
    }
    
    public func popMovieBasicFromDB() -> MovieBasicData {
        let movie_basic = realm.objects(MovieBasicData.self).filter("is_appeared == false")
        if movie_basic.count > 0 {
            try! realm.write {
                movie_basic[0].is_appeared = true
            }
            return movie_basic[0]
        }
        return MovieBasicData()
    }
    
    public func getTodayMovieFromDB(appear_day: String) -> MovieObject {
        let movies = realm.objects(MovieData.self).filter("appear_day CONTAINS '\(appear_day)'")
        if movies.count > 0 {
            return movies[0].toObject()
        }
        return MovieObject(Dictionary: [:])
    }
}


