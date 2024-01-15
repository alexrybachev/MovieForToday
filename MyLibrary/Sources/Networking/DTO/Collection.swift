//
//  Collection.swift
//
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import Foundation

/// Модель представляет собой коллекцию кино по определенному признаку:
/// жанр, страна и т.д.
public struct Collection: Decodable {
    public let category: String
    public let slug: String
    public let moviesCount: Int?
    public let cover: Cover?
    public let name: String
    public let updatedAt: String
    public let createdAt: String
}

public extension Collection {
    static let sample: [Collection] = [
        .init(category: "Category1", slug: "Slug1", moviesCount: 1, cover: nil, name: "Name1", updatedAt: "", createdAt: ""),
        .init(category: "Category2", slug: "Slug2", moviesCount: 2, cover: nil, name: "Name2", updatedAt: "", createdAt: ""),
        .init(category: "Category3", slug: "Slug3", moviesCount: 3, cover: nil, name: "Name3", updatedAt: "", createdAt: "")
    ]
}
