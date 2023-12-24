//
//  Endpoint.swift
//
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import Foundation

struct Endpoint {
    private static let list = "list"
    private static let movie = "movie"
    private static let fieldValue = "possible-values-by-field"
    
    let path: String
    let queryItems: [URLQueryItem]
    
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
    private init(
        path: String,
        @QueryBuilder queryItems: () -> [URLQueryItem] = { .init() }
    ) {
        self.path = path
        self.queryItems = queryItems()
    }
    
    //MARK: - Constructers
    @inlinable
    @inline(__always)
    static func movieList(page: Int = 1, limit: Int = 10) -> Self {
        .init(path: list) {
            paginated(page: page, limit: limit)
        }
    }
    
    @inlinable
    @inline(__always)
    static func movieList(for slug: String, page: Int = 1, limit: Int = 10) -> Self {
        .init(
            path: [list, slug].joined(separator: "/")
        ) {
            paginated(page: page, limit: limit)
        }
    }
    
    @inlinable
    @inline(__always)
    static func movie(withId id: Int) -> Self {
        .init(path: [movie, id.description].joined(separator: "/"))
    }
    
    @inlinable
    @inline(__always)
    static func movie(withName name: String, page: Int = 1, limit: Int = 10) -> Self {
        .init(
            path: [movie, name].joined(separator: "/")
        ) {
            paginated(page: page, limit: limit)
        }
    }
    
    static let genres: Self = .init(
        path: [movie, fieldValue].joined(separator: "/")
    ) {
        URLQueryItem(name: "field", value: "genres.name")
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
    enum HTTPMethod: String {
        case GET
        case PUT
        case POST
        case DELETE
    }
}
