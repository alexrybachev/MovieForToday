//
//  ExternalId.swift
//  
//
//  Created by Илья Шаповалов on 26.12.2023.
//

import Foundation

public struct ExternalId: Decodable {
    public let kpHD: String?
    public let imdb: String?
    public let tmdb: Int?
}
