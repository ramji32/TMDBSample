//
//  MovieListCell.swift
//  MovieList
//
//  Created by Abhishek Kumar on 08/08/19.
//  Copyright © 2019 Abhishek Kumar. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListCell: UITableViewCell {
    @IBOutlet weak var originalTitleLabel:  UILabel!
    @IBOutlet weak var posterImageView:     UIImageView!
    @IBOutlet weak var ratingLabel:         UILabel!
    @IBOutlet weak var voteCountLabel:      UILabel!
    @IBOutlet weak var releaseDateLabel:    UILabel!
    @IBOutlet weak var likeImageView:       UILabel!
    
    @IBOutlet weak var ratingWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingHeightConstraint: NSLayoutConstraint!
    
    static let identifier: String = "movieCell"

    
    func configure(with movie: MovieViewModel) {
        originalTitleLabel.text = movie.title
        releaseDateLabel.text   = movie.movieReleaseDate
        voteCountLabel.text     = movie.voteCount
        likeImageView.text      = movie.userChoice

        posterImageView.sd_setImage(with: movie.posterURL,
                                        placeholderImage: UIImage(named: "placeholder"),
                                        options: SDWebImageOptions.cacheMemoryOnly,
                                        completed: nil)       
        
        configureRating(with: movie)
    }
    
    func configureRating (with movie: MovieViewModel) {
        self.ratingHeightConstraint.constant = 30
        self.ratingWidthConstraint.constant = CGFloat(movie.rating)
        self.ratingLabel.setNeedsUpdateConstraints()
        self.ratingLabel.layoutIfNeeded()
    }
}
