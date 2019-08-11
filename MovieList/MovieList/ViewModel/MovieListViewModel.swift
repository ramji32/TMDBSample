//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by Abhishek Kumar on 08/08/19.
//  Copyright © 2019 Abhishek Kumar. All rights reserved.
//

import Foundation
import UIKit

let startPage: Int = 0


class MovieListViewModel {
    var delegate: PushDownloadDatatoTableDelegate?

    var onSelectedMovie: ((MovieViewModel?) -> Void)?
    private let webServiceManager = WebServiceManager()

    var movieListResponse : WebServiceManager.MoviesListResponse? {
        // Refill the array after fetching from APIs
        didSet {
            reloadMovieList()
        }
    }
    
    var movieList : [MovieViewModel] = []  {
        didSet {
        }
    }
    

    func movie(at index: Int) -> MovieViewModel? {
        guard 0..<movieList.count ~= index
        else {
                return nil
        }
        return movieList[index]
    }

    var moviesCount: Int {
        return movieList.count
    }
    
    var pageCount: Int {
        return movieListResponse?.totalPages ?? 1
    }
    
    var currentPage: Int = startPage

    func selectMovie(at index: Int) -> MovieViewModel? {
        guard let movie = movie(at: index)
        else {
                return nil
        }
        return movie
    }
    
    var isLoading : Bool = false
    
    func selectedMovie(at index: Int) {
        guard let movie = movie(at: index)
        else {
            return
        }
        onSelectedMovie?(movie)
    }
    
    func fetchMovieList(selectedIndex: Int) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if !self.isLoading &&
                self.currentPage <= self.pageCount {
                self.isLoading = !self.isLoading
                self.currentPage += 1
                
                var sortString = MovieFilter.POPULARITY.sortStr()
                
                switch selectedIndex {
                case 0:
                    sortString = MovieFilter.POPULARITY.sortStr()
                case 1:
                    sortString = MovieFilter.RATING.sortStr()
                default:
                    break
                }
                
                self.webServiceManager.fetchMovieList(page: self.currentPage, sortString: sortString ) {
                    (responseMovieList, error) in
                   
                    DispatchQueue.main.async {
                        self.isLoading = !self.isLoading
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    
                    if let error = error {
                        print("Fetch Movie error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard responseMovieList != nil
                    else {
                        return
                    }
                    self.movieListResponse = responseMovieList
                }
            }
    }
    
    func reloadMovieList () {
        for result in (movieListResponse?.results)! {
            movieList.append(MovieViewModel.init(movie: result))
        }
        delegate?.didFinishDownloading()

    }
    
}


