//
//  MovieModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 24.12.2023.
//

import Foundation

struct MovieModel {
    let urlPoster: String
    let rating: String
    let name: String
    let year: String
    let duration: String
    let genre: [Genre]
    let category: String
    
    static func getMocData() -> MovieModel {
        MovieModel(urlPoster: "https://m.media-amazon.com/images/M/MV5BZWYzOGEwNTgtNWU3NS00ZTQ0LWJkODUtMmVhMjIwMjA1ZmQwXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_.jpg",
                   rating: "4.5",
                   name: "Spider-Man",
                   year: "2021",
                   duration: "148",
                   genre: Genre.getMockData(),
                   category: "Movie")
    }
}

struct Genre: Hashable {
    let name: String
    
    static func getMockData() -> [Genre] {
        return [
            Genre(name: "action"),
            Genre(name: "fantasy"),
            Genre(name: "comedy"),
            Genre(name: "documental"),  
            Genre(name: "animation")
        ]
    }
}
