//
//  MovieList.swift
//
//
//  Created by Илья Шаповалов on 30.12.2023.
//

import Foundation

public struct MovieList: Decodable {
    public let docs: [Movie]
    public let total: Int
    public let limit: Int
    public let page: Int
    public let pages: Int
}
