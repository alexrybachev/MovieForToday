//
//  MovieModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 24.12.2023.
//

import Foundation

struct MovieModel {
    let id: Int
    let urlPoster: String
    let rating: String
    let name: String
    let year: String
    let duration: String
    let genres: [String]
    let category: String
    
    static func getMocData() -> MovieModel {
        MovieModel(id: 10,
                   urlPoster: "https://m.media-amazon.com/images/M/MV5BZWYzOGEwNTgtNWU3NS00ZTQ0LWJkODUtMmVhMjIwMjA1ZmQwXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_.jpg",
                   rating: "4.5",
                   name: "Spider-Man",
                   year: "2021",
                   duration: "148",
                   genres: Genre.getMockData(),
                   category: "Movie")
    }
}

struct Genre: Hashable {
    let ruName: String
    let enName: String
    
    static func getMockData() -> [Genre] {
        return [
            Genre(ruName: "экшн", enName: "action"),
            Genre(ruName: "фэнтези", enName: "fantasy"),
            Genre(ruName: "комедия", enName: "comedy"),
            Genre(ruName: "документальный", enName: "documental"),
            Genre(ruName: "анимация", enName: "animation")
        ]
    }
    
    static func getMockData() -> [String] {
        return [
            "action",
            "fantasy",
            "comedy",
            "documental",
            "animation"
        ]
    }
}
