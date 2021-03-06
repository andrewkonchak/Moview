//
//  MoviesFilter.swift
//  MoviesApp
//
//  Created by Andrii Konchak on 8/8/18.
//  Copyright © 2018 Andrii Konchak. All rights reserved.
//

import Foundation

enum MoviesFilter: MovieParameter {
    
    case genres([String])
    case year(Int)
    case peoples([String])
    
    var key: String {
        switch self {
        case .genres:
            return "with_genres"
        case .year:
            return "primary_release_year"
        case .peoples:
            return "with_people"
        }
    }
    
    var rawValue: Any {
        switch self {
        case .genres(let genres):
            return genres.joined(separator: ",")
        case .year(let year):
            return year
        case .peoples(let peoples):
            return peoples.joined(separator: "|")
        }
    }
}

