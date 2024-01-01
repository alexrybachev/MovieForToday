//
//  QueryBuilder.swift
//
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import Foundation

extension Endpoint {
    @resultBuilder
    struct QueryBuilder {
        static func buildBlock(_ components: URLQueryItem...) -> [URLQueryItem] {
            components
        }
        
        static func buildBlock(_ components: [URLQueryItem]...) -> [URLQueryItem] {
            components.flatMap { $0 }
        }
            
        static func buildExpression(_ expression: [URLQueryItem]) -> [URLQueryItem] {
            expression
        }
        
        static func buildExpression(_ expression: URLQueryItem) -> [URLQueryItem] {
            [expression]
        }
        
        static func buildExpression(_ expression: @escaping () -> [URLQueryItem]) -> [URLQueryItem] {
            expression()
        }
    }
}
