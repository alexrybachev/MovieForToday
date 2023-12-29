//
//  Movie.swift
//
//
//  Created by Илья Шаповалов on 26.12.2023.
//

import Foundation

public struct Movie: Decodable, Identifiable {
    public let id: Int
    public let externalId: ExternalId
    public let name: String
    public let alternativeName: String
    public let enName: String
}
