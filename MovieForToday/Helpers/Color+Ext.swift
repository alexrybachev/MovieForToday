//
//  Color+Extensions.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 24.12.2023.
//

import SwiftUI

enum PrimaryColor: String {
    case green = "customGreen"
    case mint = "customMint"
    case orange = "customOrange"
    case purple = "customPurple"
    case red = "customRed"
    case mainDark = "customMainColor"
    case softDark = "customSoftDark"
}

enum TextColors: String {
    case black = "textBlack"
    case darkGrey = "textDarkGrey"
    case grey = "textGrey"
    case lineDark = "textLineDark"
    case whiteGrey = "textWhiteGrey"
}

extension Color {
    
    static func primaryColor(_ color: PrimaryColor) -> Color {
        Color(UIColor(named: color.rawValue) ?? .white)
    }
    
    static func textColor(_ color: TextColors) -> Color {
        Color(UIColor(named: color.rawValue) ?? .white)
    }
}
