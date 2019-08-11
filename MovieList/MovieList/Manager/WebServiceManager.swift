//
//  WebServiceManager.swift
//  MovieList
//
//  Created by Abhishek Kumar on 10/08/19.
//  Copyright © 2019 Abhishek Kumar. All rights reserved.
//

import Foundation

class WebServiceManager {
  
    func fetchMovieList(page : Int, sortString: String, completion: @escaping (_ movieList: MoviesListResponse?, _ error: Error?) -> Void) {
         let urlString = URLList().tmdbBaseUrl + "sort_by=\(sortString)&api_key=\(URLList().APIKEY)&page=\(page)"
        
        // Call method to get JSOn from URL
        getJSONFromURL(urlString: urlString) { (data, error) in
            guard let data = data, error == nil else {
                return completion(nil, error)
            }
            
           //Call method to create modelView object from JSON
        self.createMovieListObjectWith(json: data, completion: { (movieList, error) in
                if let error = error {
                    return completion(nil, error)
                }
                return completion(movieList, nil)
            })
        }
    }
    
}

extension WebServiceManager {
    private func getJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                return completion(nil, error)
            }
            guard let responseData = data else {
                return completion(nil, error)
            }
            completion(responseData, nil)
        }
        task.resume()
    }
    
    private func createMovieListObjectWith(json: Data, completion: @escaping (_ data: MoviesListResponse?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            let movieList = try decoder.decode(MoviesListResponse.self, from: json)
            return completion(movieList, nil)
        } catch let error {
            print(error.localizedDescription)
            return completion(nil, error)
        }
    }
}


extension WebServiceManager {
    
    struct MoviesListResponse: Codable {
        let page: Int?
        let totalResults: Int?
        let totalPages: Int?
        let results: [Movie]?
        
        enum CodingKeys: String, CodingKey {
            case page = "page"
            case totalResults = "total_results"
            case totalPages = "total_pages"
            case results = "results"
        }
    }
}
