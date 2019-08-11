//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Abhishek Kumar on 08/08/19.
//  Copyright © 2019 Abhishek Kumar. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController, UIActionSheetDelegate {

    // MovieViewModel  variable
    var movie: MovieViewModel? {
        didSet {
            guard isViewLoaded, let movie = movie
            else {
                return
            }
            configureView(with: movie)
        }
    }
    @IBOutlet weak var moviewTitleLabel:        UILabel!
    @IBOutlet weak var moviePosterImageView:    UIImageView!
    @IBOutlet weak var moviewRatingLabel:       UILabel!
    @IBOutlet weak var moviewVoteCountLabel:    UILabel!
    @IBOutlet weak var movieReleaseDateLabel:   UILabel!
    @IBOutlet weak var movieDescriptionLabel:   UILabel!
    @IBOutlet weak var likeLabel:               UILabel!
    @IBOutlet weak var likeIndicatorLabel:      UILabel!

    @IBOutlet weak var ratingWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Detect tap on press of like ♡ in detail screen
        likeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.likeFunction(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movie = movie {
            configureView(with: movie)
        }
    }
}


extension MovieDetailViewController {
    
    // Configure detail view using MovieModelView
    func configureView(with model:MovieViewModel)  {
        self.title = model.title
        
        self.moviewTitleLabel.text      = model.title
        self.moviewVoteCountLabel.text  = model.voteCount
        self.movieReleaseDateLabel.text = model.movieReleaseDate
        self.movieDescriptionLabel.text = model.overview
        self.likeLabel.text             = model.userChoice
        
        self.moviePosterImageView.sd_setImage(with: model.posterURL,
                                              placeholderImage: UIImage(named: "placeholder"),
                                              options: SDWebImageOptions.cacheMemoryOnly,
                                              completed: nil)
        configureRatingView(with: model)
    }
    
    func configureRatingView (with movie: MovieViewModel) {
        self.ratingHeightConstraint.constant = 30
        self.ratingWidthConstraint.constant = CGFloat(movie.rating)
        self.moviewRatingLabel.setNeedsUpdateConstraints()
        self.moviewRatingLabel.layoutIfNeeded()
    }
}

extension MovieDetailViewController {
    @objc func likeFunction (_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title:"Like",
                                      message:nil,
                                      preferredStyle:.actionSheet)
        
        let like = UIAlertAction(title: Choice.like.choice(), style:.default) { _ in
            UserDefaults.standard.set(Choice.like.choice(), forKey: "\(self.movie!.movie.movieID)")
            self.likeLabel.text = self.movie?.userChoice
        }
        
        let dislike = UIAlertAction(title: Choice.dislike.choice(), style:.default) { _ in
            UserDefaults.standard.set(Choice.dislike.choice(), forKey: "\(self.movie!.movie.movieID)")
            self.likeLabel.text = self.movie?.userChoice
        }
        
        let cancel = UIAlertAction(title: "Cancel", style:.cancel) { _ in
        }
        
        // relate actions to controllers
        alert.addAction(like)
        alert.addAction(dislike)
        alert.addAction(cancel)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = self.likeLabel.frame

        present(alert, animated: true, completion: nil)
    }
}


extension MovieDetailViewController {
    static func instantialDetailViewController () -> MovieDetailViewController {
        let detailViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        return detailViewController
    }
}
