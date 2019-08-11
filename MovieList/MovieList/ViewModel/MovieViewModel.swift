//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Abhishek Kumar on 08/08/19.
//  Copyright © 2019 Abhishek Kumar. All rights reserved.
//

import Foundation

enum Choice : String {
    case empty
    case like
    case dislike
    
    func choice() -> String {
        return self.rawValue
    }
}

struct MovieViewModel {

    var movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.originalTitle
    }
    
    var overview: String {
        return movie.plotSynopsis ?? "-"
    }
    
    public var posterURL: URL? {
        if movie.posterPath != nil {
            return URL(string: URLList().posterPathURI+"\(movie.posterPath!)")
        }
        return nil
    }
    
    var movieReleaseDate: String {
       return movie.releaseDate ?? "-"
    }
    
    var userChoice : String {
        let choice : String = UserDefaults.standard.value(forKey: "\(movie.movieID)") as? String ?? ""
        if choice == Choice.like.choice() {
            return "❤️"
        }
        else if choice == Choice.dislike.choice() {
            return "💔"
        }
        return "♡"
    }
    
    var rating: Float {
        return (movie.userRating ?? 0) * 11.5
    }
    
    var voteCount : String {
        if movie.voteCount != 0 {
            return "(\(movie.voteCount ?? 0))"
        }
        return ""
    }
}
