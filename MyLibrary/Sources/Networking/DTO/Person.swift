//
//  Person.swift
//  
//
//  Created by Илья Шаповалов on 31.12.2023.
//

import Foundation

public struct Person: Decodable {
    public let id: Int
    public let photo: String?
    public let name: String?
    public let age: Int?
    public let description: String?
    public let profession: String?
    public let movies: [Movie]?
}
