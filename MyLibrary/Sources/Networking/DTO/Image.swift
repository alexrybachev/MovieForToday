//
//  Image.swift
//
//
//  Created by Илья Шаповалов on 13.01.2024.
//

import Foundation

public struct Image: Decodable {
    public let movieId: Int?
    public let type: String?
    public let language: String?
    public let url: String?
    public let previewUrl: String?
    public let height: Int?
    public let width: Int?
}
