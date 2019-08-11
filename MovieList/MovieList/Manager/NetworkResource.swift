//
//  NetworkResource.swift
//  MovieList
//
//  Created by Abhishek Kumar on 11/08/19.
//  Copyright © 2019 Abhishek Kumar. All rights reserved.
//

import Foundation

struct URLList {
    var tmdbBaseUrl : String {
        return "https://api.themoviedb.org/3/discover/movie?"
    }
    var APIKEY : String {
        return "02ecdb393eb4a51507db0ae593fce054"
    }
    
    var posterPathURI : String {
        return "https://image.tmdb.org/t/p/w500"
    }
}


enum MovieFilter : String {
    case POPULARITY = "popularity.desc"
    case RATING     = "vote_average.desc"
    
    func sortStr() -> String {
        return self.rawValue
    }
}

