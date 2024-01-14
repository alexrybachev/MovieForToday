//
//  StorageManager.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    func saveRecentMovie(with id: Int) {
        var savedMovieIds = getMovies(with: .recentKey)
        
        if savedMovieIds.firstIndex(of: id) == nil {
            savedMovieIds.append(id)
            UserDefaults.standard.set(savedMovieIds, forKey: UsersKeys.recentKey.rawValue)
        }
    }
    
    func saveFavoriteMovie(with id: Int) {
        var savedMovieIds = getMovies(with: .favoriteKey)
        if savedMovieIds.firstIndex(of: id) == nil {
            savedMovieIds.append(id)
            UserDefaults.standard.set(savedMovieIds, forKey: UsersKeys.favoriteKey.rawValue)
        }
    }
    
    func getMovies(with key: UsersKeys) -> [Int] {
        UserDefaults.standard.array(forKey: key.rawValue) as? [Int] ?? []
    }
    
}

extension StorageManager {
    
    enum UsersKeys: String {
        case recentKey = "savedMovieIds"
        case favoriteKey = "favoriteMovies"
    }
}
