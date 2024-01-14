//
//  LocaleManager.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 11.01.2024.
//

import Foundation

#warning("протестировать и при необходимости исправить LocaleManager")

final class LocaleManager: ObservableObject {
    
    @Published var currentLanguage: String
    
    init() {
        self.currentLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.current.languageCode ?? Language.en.rawValue
    }
    
    func setLanguage(_ language: Language) {
        guard Bundle.main.path(forResource: language.rawValue, ofType: "lproj") != nil else {
            return
        }
        
        UserDefaults.standard.set(language, forKey: "AppLanguage")
        
        self.currentLanguage = language.rawValue
        
        objectWillChange.send()
        
        Bundle.main.load()
    }
    
    func localizedString(_ key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
    
}

extension LocaleManager {
    
    enum Language: String {
        case en
        case ru
    }
}
