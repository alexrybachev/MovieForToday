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
        components.path = "/v1.4/".appending(path)
        
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
        path: [Subpath.movie.rawValue, Field.value].joined(separator: "/"),
        queryItems: {
            URLQueryItem(name: "field", value: "genres.name")
        })
    
    //MARK: - Movies
    @inlinable
    @inline(__always)
    static func movieList(page: Int, limit: Int) -> Self {
        .init(path: Subpath.list.rawValue) {
            paginated(page: page, limit: limit)
        }
    }
    
    @inlinable
    @inline(__always)
    static func movieList(for slug: String, page: Int, limit: Int) -> Self {
        .init(path: [Subpath.list.rawValue, slug].joined(separator: "/")) {
            paginated(page: page, limit: limit)
        }
    }
    
    @inlinable
    @inline(__always)
    static func movie(withId id: Int) -> Self {
        .init(path: [Subpath.movie.rawValue, id.description].joined(separator: "/"))
    }
    
    @usableFromInline
    static let top10: Self = .init(path: Subpath.movie.rawValue) {
        paginated(page: 1, limit: 10)
        URLQueryItem(name: Field.required, value: "top10")
    }
    
    @inlinable
    @inline(__always)
    static func top250(page: Int, limit: Int) -> Self {
        .init(path: Subpath.movie.rawValue) {
            paginated(page: page, limit: limit)
            URLQueryItem(name: Field.required, value: "top250")
        }
    }
    
    @inlinable
    @inline(__always)
    static func searchMovie(byName name: String, page: Int, limit: Int) -> Self {
        .init(path: Subpath.movie.rawValue.appending("/search")) {
            paginated(page: page, limit: limit)
            URLQueryItem(name: Field.query, value: name)
        }
    }
    
    @inlinable
    @inline(__always)
    static func topRatedMovies(page: Int, limit: Int) -> Self {
        .init(path: Subpath.movie.rawValue) {
            paginated(page: page, limit: limit)
            URLQueryItem(name: Field.sortion, value: "rating.kp")
            URLQueryItem(name: "sortType", value: 1.description)
        }
    }
    
    //MARK: - Person
    @inlinable
    @inline(__always)
    static func person(withId id: Int) -> Self {
        .init(path: [Subpath.person.rawValue, id.description].joined(separator: "/"))
    }
    
    @inlinable
    @inline(__always)
    static func searchPerson(byName name: String, page: Int, limit: Int) -> Self {
        .init(path: Subpath.person.rawValue.appending("/search")) {
            paginated(page: page, limit: limit)
            URLQueryItem(name: Field.query, value: name)
        }
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
    
}

extension Endpoint {
    @usableFromInline
    struct Field {
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
    enum Subpath: String {
        case list
        case movie
        case image
        case person
    }
}
