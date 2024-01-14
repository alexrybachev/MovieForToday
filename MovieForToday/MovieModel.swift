//
//  MovieModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 24.12.2023.
//

import Foundation
import Networking

struct MovieModel: Identifiable {
    let id: Int
    let urlPoster: String
    let backdrop: String
    let rating: String
    let name: String
    let description: String
    let year: String
    let duration: String
    let genres: [String]
    let persons: [MoviePerson]
    let trailerUrl: String
    
    static func getMocData() -> MovieModel {
        MovieModel(id: 10,
                   urlPoster: "https://m.media-amazon.com/images/M/MV5BZWYzOGEwNTgtNWU3NS00ZTQ0LWJkODUtMmVhMjIwMjA1ZmQwXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_.jpg",
                   backdrop: "https://m.media-amazon.com/images/M/MV5BZWYzOGEwNTgtNWU3NS00ZTQ0LWJkODUtMmVhMjIwMjA1ZmQwXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_.jpg",
                   rating: "4.5",
                   name: "Spider-Man",
                   description: "Description",
                   year: "2021",
                   duration: "148",
                   genres: Genre.getMockData(),
                   persons: [],
                   trailerUrl: ""
        )
    }
}

struct MoviePerson: Identifiable {
    let id: Int
    let photo: String
    let name: String
    let profession: String
}

struct MovieImage {
    let id: Int
    let url: String
    let previewUrl: String
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

