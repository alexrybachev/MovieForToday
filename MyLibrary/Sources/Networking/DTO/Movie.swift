//
//  Movie.swift
//
//
//  Created by Илья Шаповалов on 26.12.2023.
//

import Foundation

public struct Logo: Decodable {
    public let url: String?
}

public struct ImageContent: Decodable {
    public let url: String?
    public let previewUrl: String?
}


public struct Movie: Decodable, Identifiable {
    public let id: Int
    public let externalId: ExternalId?
    public let name: String?
    public let year: Int?
    public let description: String?
    public let slogan: String?
    public let movieLength: Int?
    public let ageRating: Int?
    public let logo: Logo?
    public let poster: ImageContent
    public let backdrop: ImageContent?
    public let top10: Int?
    public let top250: Int?
    public let persons: [Person]?
    public let rating: Rating
    public let videos: VideoContent?
    public let genres: [FieldValue]?
}

public extension Movie {
    struct MediaContent: Decodable {
        public let url: String?
        public let name: String?
        public let site: String?
        public let type: String?
        public let size: Int?
    }
}

public extension Movie {
    struct VideoContent: Decodable {
        public let trailers: [MediaContent]
        public let teasers: [MediaContent]?
    }
}

public extension Movie {
    struct Rating: Decodable {
        public let kp: Double
        public let imdb: Double?
        public let tmdb: Double?
        public let filmCritics: Double?
        public let russianFilmCritics: Double?
        public let await: Double?
    }
}

