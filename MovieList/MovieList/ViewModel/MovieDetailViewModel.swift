//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Abhishek Kumar on 11/08/19.
//  Copyright © 2019 Abhishek Kumar. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
        
    private let movieModel: MovieViewModel
    var onSelection: (() -> Void)?

    init(movieModel: MovieViewModel) {
        self.movieModel = movieModel
            self.onSelection?()
        }
}
    

