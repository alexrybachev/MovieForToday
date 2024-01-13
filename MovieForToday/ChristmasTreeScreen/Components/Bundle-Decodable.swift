//
//  Bundle-Decodable.swift
//  MovieForToday
//
//  Created by Alex on 12.01.2024.
//

import SwiftUI

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
