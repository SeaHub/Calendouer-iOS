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
    
    public func addMovieToDB(movie: MovieObject) {
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
        
        try! realm.write {
            realm.add(movieData)
        }
    }
}


