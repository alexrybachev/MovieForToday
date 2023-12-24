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
    public let moviesCount: Int
    public let cover: Cover
    public let name: String
    public let updatedAt: String
    public let createdAt: String
}
