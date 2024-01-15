//
//  SwitchCategoriesButton.swift
//  MovieForToday
//
//  Created by Alex on 05.01.2024.
//

import SwiftUI

struct SwitchCategoriesButton: View {
    let genre: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Text(genre.capitalized)
            .padding([.top, .bottom], 8)
            .padding([.leading, .trailing], 12)
            .foregroundStyle(isSelected ? Color.customMint : Color.textWhiteGrey)
            .if(isSelected) { $0.background(.customSoftDark) }
            .font(.custom(.montMedium, size: 12))
            .clipShape(.rect(cornerRadius: 8))
            .onTapGesture(perform: action)
    }
}

#Preview {
    ZStack {
        Color.customMain.ignoresSafeArea()
        HStack {
            SwitchCategoriesButton(genre: "All", isSelected: true, action: {})
            SwitchCategoriesButton(genre: "Boevik", isSelected: false, action: {})
        }
    }
}
