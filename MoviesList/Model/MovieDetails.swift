//
//  MovieDetails.swift
//  MoviesList
//
//  Created by Nabilah Ashriyah on 26/11/20.
//

import Foundation

class MovieDetails {
    struct ProductionCompanies {
        var id: Int
        var logo_path: String
        var name: String
        var origin_country: String
        
        init(_ id: Int, _ logo_path: String, _ name: String, _ origin_country: String) {
            self.id = id
            self.logo_path = logo_path
            self.name = name
            self.origin_country = origin_country
        }
    }
    
    struct ProductionCountries {
        var iso_3166_1: Int
        var name: String
        
        init(_ iso: Int, _ name: String) {
            self.iso_3166_1 = iso
            self.name = name
        }
    }
    
    struct SpokenLanguage {
        var iso_639_1: String
        var name: String
        
        init(_ iso: String, _ name: String) {
            self.iso_639_1 = iso
            self.name = name
        }
    }
    
    var adult: Bool?
    var backdrop_path: String?
    var budget: Int?
    var genres: [Genre] = []
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: [ProductionCompanies] = []
    var production_countries: [ProductionCountries] = []
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: [SpokenLanguage] = []
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}

