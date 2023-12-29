//
//  Extensions.swift
//  
//
//  Created by Илья Шаповалов on 27.12.2023.
//

import Foundation

extension URLCache {
    func cachedNetworkResponse(for request: URLRequest) -> NetworkManager.Response? {
        guard let response = cachedResponse(for: request) else {
            return nil
        }
        return (response.data, response.response)
    }
}

extension CachedURLResponse {
    convenience init(_ response: NetworkManager.Response) {
        self.init(response: response.response, data: response.data)
    }
}
