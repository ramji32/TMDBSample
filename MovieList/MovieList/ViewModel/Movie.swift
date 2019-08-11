//
//  Movie.swift
//  MovieList
//
//  Created by Abhishek Kumar on 08/08/19.
//  Copyright © 2019 Abhishek Kumar. All rights reserved.
//

import Foundation

struct Movie : Codable {
    let movieID:        Int
    let userRating:     Float?
    let releaseDate:    String?
    let posterPath:     String?
    let originalTitle:  String
    let plotSynopsis:   String?
    let voteCount:      Int?
    let choice:         String?

    
    enum CodingKeys: String, CodingKey {
        case movieID        = "id"
        case userRating     = "vote_average"
        case releaseDate    = "release_date"
        case posterPath     = "poster_path"
        case originalTitle  = "original_title"
        case plotSynopsis   = "overview"
        case voteCount      = "vote_count"
        case choice
    }
}
