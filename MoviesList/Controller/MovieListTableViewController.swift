//
//  MovieListTableViewController.swift
//  MoviesList
//
//  Created by Nabilah Ashriyah on 26/11/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieListTableViewController: UITableViewController {
    
    var movies = [Movie]()
    private var page = 1
    private var idGenre: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadData(idGenre: String, page: Int) {
        self.idGenre = idGenre
        AF.request("https://api.themoviedb.org/3/discover/movie?api_key=1e0849c1e1e9206f7577ddbb40971338&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_genres=\(idGenre)").responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in 0 ..< json["results"].count{
                    let id = json["results"][i]["id"].int!
                    let title = json["results"][i]["title"].string!
                    let release_date = json["results"][i]["release_date"].string
                    let poster_path = json["results"][i]["poster_path"].string
                    let vote_average = json["results"][i]["vote_average"].double
                    self.movies.append(Movie(id,title, release_date ?? "", poster_path ?? "", vote_average: vote_average ?? 0))
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                return
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].title
        cell.detailTextLabel?.text = "\(movies[indexPath.row].vote_average)\u{2606}  \u{2022} " + movies[indexPath.row].release_date
        let poster = movies[indexPath.row].poster_path
        if poster != "" {
            cell.imageView?.downloadImage(from: poster)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row == (movies.count - 1) {
            page += 1
            loadData(idGenre: self.idGenre, page: page)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoMovieDetails", sender: indexPath.row)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
//            movieDetailsViewController.title = movies[sender as! Int].title
            movieDetailsViewController.loadData(idMovie: String(movies[sender as! Int].id))
        }
    }

}

extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from poster_path: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w154\(poster_path)")!
        getData(from: url) {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
}
