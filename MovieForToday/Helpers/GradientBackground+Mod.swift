//
//  GradientBackground+Mod.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 27.12.2023.
//

import SwiftUI

struct GradientBackground: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content.foregroundStyle(LinearGradient(gradient: Gradient(colors: [color]), startPoint: .leading, endPoint: .trailing))
    }
}

extension View {
    func gradientBackground(color: Color) -> some View {
        self.modifier(GradientBackground(color: color))
    }
}
