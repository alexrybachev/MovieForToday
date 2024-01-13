//
//  PersonList.swift
//  
//
//  Created by Илья Шаповалов on 12.01.2024.
//

import Foundation

public struct PersonList: Decodable {
    public let docs: [Person]
    public let total: Int
    public let limit: Int
    public let page: Int
    public let pages: Int
}
