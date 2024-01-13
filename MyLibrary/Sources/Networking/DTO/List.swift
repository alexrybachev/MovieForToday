//
//  List.swift
//
//
//  Created by Илья Шаповалов on 30.12.2023.
//

import Foundation

public struct List<T: Decodable>: Decodable {
    public let docs: [T]
    public let total: Int
    public let limit: Int
    public let page: Int
    public let pages: Int
}
