//
//  MoviesApi.swift
//  MoviesApp
//
//  Created by Andrii Konchak on 7/30/18.
//  Copyright © 2018 Andrii Konchak. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionHandler = (DiscoveryResponse?) -> ()
//typealias Filter = (key: String, value: Any)

//enum Filter {
//
//    case genres([String])
//    case year(Int)
//
//    var key: String {
//        switch self {
//        case .genres:
//            return "with_genres"
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
//
//    var rawValue: Any {
//
//        switch self {
//        case .genres(let genres):
//            return genres.joined(separator: "|")
//            
//            case .year(<#T##Int#>)
//        }
//
//    }
//}

class MoviesApi {

    static let shared = MoviesApi()
//    let moviesMod = DiscoveryResponse.self
    
    enum Constants {
        static let baseUrlString = "https://api.themoviedb.org/3"
        static let apiKey = "fef7899f9aac38745096ad5f347e48ed"
    }

    func downloadMovies(parameters: [String: Any], completionHandler: @escaping CompletionHandler) {


        Alamofire.request(Constants.baseUrlString + "/discover/movie?api_key=" + Constants.apiKey + "&language=en-US&sort_by=popularity.asc", parameters: parameters).responseJSON { (response) in
           
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
}
