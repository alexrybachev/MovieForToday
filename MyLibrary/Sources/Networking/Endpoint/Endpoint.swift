//
//  Endpoint.swift
//
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    let method: HTTPMethod
    
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
        method: HTTPMethod,
        path: String,
        @QueryBuilder queryItems: () -> [URLQueryItem]
    ) {
        self.method = method
        self.path = path
        self.queryItems = queryItems()
    }
    
    //MARK: - URLRequest builder
    @inlinable
    @inline(__always)
    func request(_ payload: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    //MARK: - Constructers
    @inlinable
    @inline(__always)
    static func movieList(page: Int = 1, limit: Int = 10) -> Self {
        .init(method: .GET, path: "list") {
            paginated(page: page, limit: limit)
        }
    }
    
    @inlinable
    @inline(__always)
    static func movieList(for slug: String, page: Int = 1, limit: Int = 10) -> Self {
        .init(method: .GET, path: "list/".appending(slug)) {
            paginated(page: page, limit: limit)
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
    enum HTTPMethod: String {
        case GET
        case PUT
        case POST
        case DELETE
    }
}
