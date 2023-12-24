//
//  Cover.swift
//
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import Foundation

/// Модель содержит в себе ссылки на постеры
/// в оригинальном и компактном разрешении
public struct Cover: Decodable {
    public let url: String
    public let previewUrl: String
}
