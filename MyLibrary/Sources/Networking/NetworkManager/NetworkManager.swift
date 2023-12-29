//
//  NetworkManager.swift
//
//
//  Created by Илья Шаповалов on 27.12.2023.
//

import Foundation

public final class NetworkManager {
    typealias Response = (data: Data, response: URLResponse)
    
    private let apiKey: String
    private let session: URLSession
    private let cache: URLCache
    
    init(
        apiKey: String,
        timeout: TimeInterval = 10,
        cache: URLCache = .shared
    ) {
        self.apiKey = apiKey
        self.cache = cache
        
        var config = URLSessionConfiguration.default
        config.urlCache = cache
        config.timeoutIntervalForResource = timeout
        
        self.session = URLSession(configuration: config)
    }
    
    func perform(_ request: URLRequest) async {
        
    }
    
}

private extension NetworkManager {
    func fetch(_ request: URLRequest) async -> Result<Response, Error> {
        if let cached = cache.cachedResponse(for: request) {
            return .success((cached.data, cached.response))
        }
        do {
            let response: Response = try await session.data(for: request)
            cache.storeCachedResponse(.init(response), for: request)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}


