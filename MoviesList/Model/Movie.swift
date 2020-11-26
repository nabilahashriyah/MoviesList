//
//  Movie.swift
//  MoviesList
//
//  Created by Nabilah Ashriyah on 26/11/20.
//

import Foundation

class Movie {
//    var popularity: String
//    var overview: String
    var release_date: String
    var id: Int
//    var adult: String
//    var backdrop_path: String
    var title: String
//    var genre_ids: String
//    var original_language: String
//    var original_title: String
    var poster_path: String
//    var vote_count: String
//    var video: String
    var vote_average: Double
    
    init(_ id: Int, _ title: String, _ release_date: String, _ poster_path: String, vote_average: Double) {
        self.id = id
        self.title = title
        self.release_date = release_date
        self.poster_path = poster_path
        self.vote_average = vote_average
    }
}
