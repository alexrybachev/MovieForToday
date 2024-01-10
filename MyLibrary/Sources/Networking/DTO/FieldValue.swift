//
//  FieldValue.swift
//
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import Foundation

/// Критерий фильма: жанр, страна и т.д.
public struct FieldValue: Decodable {
    public let name: String
    public let slug: String
}
