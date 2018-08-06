//
//  MoviesApi.swift
//  MoviesApp
//
//  Created by Andrii Konchak on 7/30/18.
//  Copyright © 2018 Andrii Konchak. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

typealias CompletionHandler = (DiscoveryResponse?) -> ()

class MoviesApi {

    static let shared = MoviesApi()
    
    enum Constants {
        static let baseUrlString = "https://api.themoviedb.org/3"
        static let apiKey = "fef7899f9aac38745096ad5f347e48ed"
    }

    func downloadMovies(parameters: [String : Any], completionHandler: @escaping CompletionHandler) {

        Alamofire.request(Constants.baseUrlString + "/discover/movie?api_key=" + Constants.apiKey + "&language=uk-UA&sort_by=popularity.desc", parameters: parameters).responseJSON { (response) in
           
            DispatchQueue.main.async {
                guard let data = response.data else { return }
                
                do {
                    let moviesDescription = try JSONDecoder().decode(DiscoveryResponse.self, from: data)
                    completionHandler(moviesDescription)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func downloadMovies(filters: [MoviesFilter], completionHandler: @escaping CompletionHandler) {
        
        var parameters: [String: Any] = [:]
        for filter in filters {
            parameters[filter.key] = filter.rawValue
        }
        
        downloadMovies(parameters: parameters, completionHandler: completionHandler)
    }
}
