//
//  MovieDetailsViewController.swift
//  MoviesList
//
//  Created by Nabilah Ashriyah on 26/11/20.
//
// https://www.tutorialspoint.com/how-do-i-load-an-image-by-url-on-ios-device-using-swift
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieStatus: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieTagline: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movieDetails = MovieDetails()

    // \u2022 bullet
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadData(idMovie: String) {
        AF.request("https://api.themoviedb.org/3/movie/\(idMovie)?api_key=1e0849c1e1e9206f7577ddbb40971338&language=en-US").responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.movieDetails.title = json["title"].string!
                self.movieDetails.release_date = json["release_date"].string
                self.movieDetails.poster_path = json["poster_path"].string
                self.movieDetails.runtime = json["runtime"].int
                self.movieDetails.tagline = json["tagline"].string
                self.movieDetails.overview = json["overview"].string
                self.movieDetails.status = json["status"].string
                self.movieDetails.release_date = json["release_date"].string
                self.movieDetails.vote_average = json["vote_average"].double
                for i in 0 ..< json["genres"].count {
                    let id = json["genres"][i]["id"].int!
                    let name = json["genres"][i]["name"].string!
                    self.movieDetails.genres.append(Genre(id,name))
                }
                self.setupView()
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func setupView() {
        if let poster = movieDetails.poster_path {
            movieImage.downloadImage(from: poster)
        }
        movieTitle.text = movieDetails.title
        movieStatus.text = "\(movieDetails.status!) \u{2022} \(movieDetails.release_date!)"
        var genreString = ""
        for x in 0..<movieDetails.genres.count {
            if x != (movieDetails.genres.count - 1) {
                genreString += "\(movieDetails.genres[x].name), "
            } else {
                genreString += movieDetails.genres[x].name
            }
        }
        movieGenre.text = genreString
        movieTime.text = "\(movieDetails.runtime!) min"
        movieRate.text = "\(movieDetails.vote_average ?? 0.0) \u{2606}"
        movieTagline.text = movieDetails.tagline
        movieOverview.text = movieDetails.overview
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
