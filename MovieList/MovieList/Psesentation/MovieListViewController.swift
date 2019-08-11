//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Abhishek Kumar on 08/08/19.
//  Copyright © 2019 Abhishek Kumar. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var sortSegmentView: UISegmentedControl!
    
    private var sortString = MovieFilter.POPULARITY.sortStr()
    var movieListViewModel =  MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        
        // Set delegate object to self.
        movieListViewModel.delegate = self;
        
        // Need to do this to call the detail view controller when row is clicked
        registerDetailView()
        
        // Set 1 as starting page and call loadData to fetch data from modelView
        self.movieListViewModel.currentPage = startPage
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload table on view appear, This is done to update the like,dislike status after returning from detail screen
        self.movieListTableView.reloadData()
    }
    
    // Method called on segmentation button click
    @IBAction func sortMovieList(_ sender: Any) {
        self.movieListViewModel.currentPage = startPage
        resetTableView()
        loadData()
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel.moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movieListViewModel.selectMovie(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier) as! MovieListCell
        cell.configure(with:movie!)
        
        // Fetch next page data when last ROW is loaded
        if indexPath.row == movieListViewModel.moviesCount - 1 {
            loadData()
        }
        return cell
    }
}

extension MovieListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieListViewModel.selectedMovie(at: indexPath.row)
    }
}

extension MovieListViewController: PushDownloadDatatoTableDelegate {
    
    //Reload table when data has been fetched from server
    func didFinishDownloading() {
        DispatchQueue.main.async {
            self.movieListTableView.reloadData()
        }
    }
}


extension MovieListViewController {
    
    //This will load the detail view when ever row is selected
    func registerDetailView()  {
        let navigation : UINavigationController = navigationController!
        let detailsScreen = MovieDetailViewController.instantialDetailViewController()
        
        movieListViewModel.onSelectedMovie = { [weak navigation] movie in
            if movie != nil {
                detailsScreen.movie = movie
                navigation?.pushViewController(detailsScreen, animated: true)
            }
        }
    }
}

extension MovieListViewController {
    
    func loadData()  {
        movieListViewModel.fetchMovieList(selectedIndex: self.sortSegmentView.selectedSegmentIndex)
    }
    
    func resetTableView() {
        self.movieListViewModel.movieList = []
        self.movieListTableView.reloadData()
    }
}
