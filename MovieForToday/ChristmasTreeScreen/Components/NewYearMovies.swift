//
//  NewYearMovies.swift
//  MovieForToday
//
//  Created by Alex on 12.01.2024.
//

import Foundation

struct NewYearMovies: Decodable {
    let movies: [NYMovie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "newyear_movies"
    }
}

struct NYMovie: Decodable {
    let number: Int
    let title: String
}
