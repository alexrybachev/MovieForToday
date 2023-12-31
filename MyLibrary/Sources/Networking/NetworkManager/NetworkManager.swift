//
//  NetworkManager.swift
//
//
//  Created by Илья Шаповалов on 27.12.2023.
//

import Foundation

public final class NetworkManager {
    public typealias Response = (data: Data, response: URLResponse)

    @usableFromInline
    let session: URLSession
    @usableFromInline
    let apiKey: String
    
    private let cache: URLCache
    
    //MARK: - init(_:)
    public init(
        apiKey: String,
        timeout: TimeInterval = 10,
        cache: URLCache = .shared
    ) {
        self.apiKey = apiKey
        self.cache = cache
        
        let config = URLSessionConfiguration.default
        config.urlCache = cache
        config.timeoutIntervalForResource = timeout
        
        self.session = URLSession(configuration: config)
    }
    
    //MARK: - Public methods
    @inlinable
    public func getAllGenres() async throws -> [FieldValue] {
        try await performRequest(.genres, model: [FieldValue].self)
    }
    
    @inlinable
    public func getTop10Movies() async throws -> MovieList {
        try await performRequest(.top10, model: MovieList.self)
    }
    
    @inlinable
    public func getTop250Movies(page: Int = 1, limit: Int = 10) async throws -> MovieList {
        try await performRequest(.top250(page: page, limit: limit), model: MovieList.self)
    }
    
    @inlinable
    public func getMovieList(page: Int = 1, limit: Int = 10) async throws -> CollectionList {
        try await performRequest(.movieList(page: page, limit: limit), model: CollectionList.self)
    }
    
    @inlinable
    public func getMovies(for slug: String, page: Int = 1, limit: Int = 10) async throws -> Collection {
        try await performRequest(.movieList(for: slug, page: page, limit: limit), model: Collection.self)
    }
    
    @inlinable
    public func getMovie(withId id: Int) async throws -> Movie {
        try await performRequest(.movie(withId: id), model: Movie.self)
    }
    
    @inlinable
    public func searchMovie(named name: String, page: Int = 1, limit: Int = 10) async throws -> MovieList {
        try await performRequest(.searchMovie(byName: name, page: page, limit: limit), model: MovieList.self)
    }
    
    @inlinable
    public func getTopRatedMovies(page: Int = 1, limit: Int = 10) async throws -> MovieList {
        try await performRequest(.topRatedMovies(page: page, limit: limit), model: MovieList.self)
    }
    
    //MARK: - Internal methods
    @inlinable
    @inline(__always)
    func performRequest<T: Decodable>(_ endpoint: Endpoint, model type: T.Type) async throws -> T {
        try await Box(endpoint)
            .map(\.url)
            .map { URLRequest(url: $0) }
            .map(addKey(apiKey))
            .asyncMap(session.data(for:))
            .map(\.0)
            .map(decode(type.self, decoder: JSONDecoder()))
            .value
    }
    
    @inlinable
    @inline(__always)
    func addKey(_ token: String) -> (URLRequest) -> URLRequest {
        { request in
            var request = request
            request.setValue(token, forHTTPHeaderField: "X-API-KEY")
            return request
        }
    }
    
    @inlinable
    @inline(__always)
    func decode<T: Decodable>(_ type: T.Type, decoder: JSONDecoder) -> (Data) throws -> T {
        { try decoder.decode(type.self, from: $0) }
    }
    
}
