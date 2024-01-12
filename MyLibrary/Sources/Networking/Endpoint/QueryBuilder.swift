//
//  QueryBuilder.swift
//
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import Foundation

extension Endpoint {
    @usableFromInline
    @resultBuilder
    enum QueryBuilder {
        @inlinable
        static func buildBlock(_ components: URLQueryItem...) -> [URLQueryItem] {
            components
        }
        
        @inlinable
        static func buildBlock(_ components: [URLQueryItem]...) -> [URLQueryItem] {
            components.flatMap { $0 }
        }
            
        @inlinable
        static func buildExpression(_ expression: [URLQueryItem]) -> [URLQueryItem] {
            expression
        }
        
        @inlinable
        static func buildExpression(_ expression: URLQueryItem) -> [URLQueryItem] {
            [expression]
        }
        
        @inlinable
        static func buildExpression(_ expression: @escaping () -> [URLQueryItem]) -> [URLQueryItem] {
            expression()
        }
    }
}
