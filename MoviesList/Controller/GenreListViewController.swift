//
//  GenreListViewController.swift
//  MoviesList
//
//  Created by Nabilah Ashriyah on 25/11/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class GenreListViewController: UIViewController {

    @IBOutlet weak var genreTableView: UITableView!
    @IBOutlet weak var pagination: UIPageControl!
    
    var genres = [Genre]()
    
    private var page = 1
    
    private var totalPage = 1
    
    private var rowNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Genres"
        
        rowNumber = Int(genreTableView.frame.size.height / 50)
        
        // Do any additional setup after loading the view.
        self.genreTableView.dataSource = self
        self.genreTableView.delegate = self
        loadData()
    }
    
    private func loadData(){
        AF.request("https://api.themoviedb.org/3/genre/movie/list?api_key=1e0849c1e1e9206f7577ddbb40971338&language=en-US").responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in 0 ..< json["genres"].count{
                    let id = json["genres"][i]["id"].int!
                    let name = json["genres"][i]["name"].string!
                    self.genres.append(Genre(id,name))
                }
                self.totalPage = self.genres.count / self.rowNumber
                if (self.genres.count % self.rowNumber) != 0 {
                    self.totalPage += 1
                }
                self.pagination.numberOfPages = self.totalPage
                self.genreTableView.reloadData()
            case .failure(let error):
                print(error)
                return
            }
        }
    }

    @IBAction func paginationDidChange(_ sender: Any) {
        page = pagination.currentPage + 1
        genreTableView.reloadData()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if page < totalPage {
            page += 1
            pagination.currentPage = page - 1
            genreTableView.reloadData()
        }
    }
    
    @IBAction func prevButton(_ sender: Any) {
        if page > 1 {
            page -= 1
            pagination.currentPage = page - 1
            genreTableView.reloadData()
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let movieListTableViewController = segue.destination as? MovieListTableViewController {
            movieListTableViewController.title = genres[sender as! Int].name
            movieListTableViewController.loadData(idGenre: String(genres[sender as! Int].id), page: 1)
        }
    }
    

}

extension GenreListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch page {
        case totalPage:
            return genres.count % rowNumber
        default:
            return rowNumber
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreTableViewCell", for: indexPath)
        cell.textLabel?.text = genres[indexPath.row + (rowNumber * (page - 1))].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoMovieList", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

