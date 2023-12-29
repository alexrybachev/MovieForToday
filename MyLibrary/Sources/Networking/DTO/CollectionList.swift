//
//  CollectionList.swift
//
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import Foundation

public struct CollectionList: Decodable {
    public let docs: [Collection]
    public let total: Int
    public let limit: Int
    public let page: Int
    public let pages: Int
}
