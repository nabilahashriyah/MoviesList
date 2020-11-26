//
//  MovieListManager.swift
//  MoviesList
//
//  Created by Nabilah Ashriyah on 25/11/20.
//
// https://erthru.medium.com/handle-restapi-menggunakan-alamofire-di-swift-4-7b1084ab7e47
//

import Foundation

class MovieListManager {
    
    var genres = [Genre]()
    
    func startURLSession() {
        let urlString = "https:// api.themoviedb.org"
        
        https://api.themoviedb.org/3/genre/movie/list?api_key=1e0849c1e1e9206f7577ddbb40971338&language=en-US
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {
                (data, res, err) in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(Response.self, from: data) {
                        print(json)
                    }
                }
            } .resume()
            print("finished")
        }
    }
    
}
