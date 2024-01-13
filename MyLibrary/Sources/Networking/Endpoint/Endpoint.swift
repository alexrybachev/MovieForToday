//
//  Endpoint.swift
//
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import Foundation

@usableFromInline
struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    @usableFromInline
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.kinopoisk.dev"
        components.path = path
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            fatalError("Unable to create url from components: \(components)")
        }
        return url
    }
    
    //MARK: - init(_:)
    @usableFromInline
    init(
        path: String,
        @QueryBuilder queryItems: () -> [URLQueryItem] = { .init() }
    ) {
        self.path = path
        self.queryItems = queryItems()
    }
    
    //MARK: - Constructers
    @usableFromInline
    static let genres: Self = .init(
        path: [APIVersion.old, Subpath.movie.rawValue, Field.value].joined(separator: "/"),
        queryItems: {
            URLQueryItem(name: "field", value: "genres.name")
        })
    
    //MARK: - Movies
    @inlinable
    @inline(__always)
    static func movieList(page: Int, limit: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.list.rawValue].joined(separator: "/"),
            queryItems: {
                paginated(page: page, limit: limit)
                URLQueryItem(name: Field.required, value: "cover.url")
                URLQueryItem(name: Field.required, value: "cover.previewUrl")
            })
    }
    
    @inlinable
    @inline(__always)
    static func movies(for slug: String, page: Int, limit: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.movie.rawValue].joined(separator: "/"),
            queryItems: {
                paginated(page: page, limit: limit)
                baseFields
                URLQueryItem(name: "genres.name", value: slug)
            })
    }
    
    @inlinable
    @inline(__always)
    static func movie(withId id: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.movie.rawValue, id.description].joined(separator: "/")
        )
    }
    
    @inlinable
    @inline(__always)
    static func top10(page: Int, limit: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.movie.rawValue].joined(separator: "/"),
            queryItems: {
                paginated(page: 1, limit: 10)
                baseFields
                URLQueryItem(name: Field.required, value: SelectFields.top10.rawValue)
            })
    }
    
    @inlinable
    @inline(__always)
    static func top250(page: Int, limit: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.movie.rawValue].joined(separator: "/"),
            queryItems: {
                paginated(page: page, limit: limit)
                URLQueryItem(name: Field.required, value: SelectFields.top250.rawValue)
                baseFields
            })
    }
    
    @inlinable
    @inline(__always)
    static func searchMovie(byName name: String, page: Int, limit: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.movie.rawValue, "search"].joined(separator: "/"),
            queryItems: {
                paginated(page: page, limit: limit)
                URLQueryItem(name: Field.query, value: name)
                baseFields
            })
    }
    
    @inlinable
    @inline(__always)
    static func topRatedMovies(page: Int, limit: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.movie.rawValue].joined(separator: "/"),
            queryItems: {
                paginated(page: page, limit: limit)
                URLQueryItem(name: Field.sortion, value: "rating.kp")
                URLQueryItem(name: "sortType", value: 1.description)
                baseFields
            })
    }
    
    @inlinable
    @inline(__always)
    static func moviesReleasedAt(year: Int, page: Int, limit: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.movie.rawValue].joined(separator: "/"),
            queryItems: {
                paginated(page: page, limit: limit)
                baseFields
                URLQueryItem(name: "releaseYears.start", value: year.description)
            })
    }
    
    //MARK: - Person
    @inlinable
    @inline(__always)
    static func person(withId id: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.person.rawValue, id.description].joined(separator: "/")
        )
    }
    
    @inlinable
    @inline(__always)
    static func searchPerson(byName name: String, page: Int, limit: Int) -> Self {
        .init(
            path: [APIVersion.new, Subpath.person.rawValue, "search"].joined(separator: "/"),
            queryItems: {
                paginated(page: page, limit: limit)
                URLQueryItem(name: Field.query, value: name)
            })
    }
    
}

//MARK: - Helpers
extension Endpoint {
    @inlinable
    @inline(__always)
    @QueryBuilder
    static func paginated(page: Int, limit: Int) -> [URLQueryItem] {
        URLQueryItem(name: "page", value: page.description)
        URLQueryItem(name: "limit", value: limit.description)
    }
    
    @usableFromInline
    @QueryBuilder
    static var baseFields: [URLQueryItem] {
        URLQueryItem(name: Field.required, value: "id")
        URLQueryItem(name: Field.required, value: "name")
        URLQueryItem(name: Field.required, value: "rating.kp")
        URLQueryItem(name: Field.required, value: "poster.url")
        URLQueryItem(name: Field.required, value: "genres.name")
    }
    
    @usableFromInline
    @QueryBuilder
    static var detailFields: [URLQueryItem] {
        URLQueryItem(name: Field.selectField, value: "year")
        URLQueryItem(name: Field.selectField, value: "ageRating")
        URLQueryItem(name: Field.selectField, value: "movieLength")
        URLQueryItem(name: Field.selectField, value: "description")
//        URLQueryItem(name: Field.required, value: "rating.kp")
        URLQueryItem(name: Field.required, value: "backdrop.url")
        URLQueryItem(name: Field.required, value: "logo.url")
        URLQueryItem(name: Field.required, value: "videos.trailers.url")
    }
    
}

extension Endpoint {
    @usableFromInline
    enum Field {
        @usableFromInline
        static let selectField = "selectFields"
        @usableFromInline
        static let value = "possible-values-by-field"
        @usableFromInline
        static let required = "notNullFields"
        @usableFromInline
        static let sortion = "sortField"
        @usableFromInline
        static let query = "query"
    }
    
    @usableFromInline
    enum APIVersion {
        @usableFromInline
        static let old = "/v1"
        @usableFromInline
        static let new = "/v1.4"
    }
    
    @usableFromInline
    enum Subpath: String {
        case list
        case movie
        case image
        case person
    }
    
    @usableFromInline
    enum SelectFields: String {
        case id
        case externalId
        case name
        case enName
        case alternativeName
        case names
        case description
        case shortDescription
        case slogan
        case type
        case typeNumber
        case isSeries
        case status
        case year
        case releaseYears
        case rating
        case ratingMpaa
        case ageRating
        case votes
        case seasonsInfo
        case budget
        case audience
        case movieLength
        case seriesLength
        case totalSeriesLength
        case genres
        case countries
        case poster
        case backdrop
        case logo
        case ticketsOnSale
        case videos
        case networks
        case persons
        case facts
        case fees
        case premiere
        case similarMovies
        case sequelsAndPrequels
        case watchability
        case lists
        case top10
        case top250
        case updatedAt
        case createdAt
    }
    
}
