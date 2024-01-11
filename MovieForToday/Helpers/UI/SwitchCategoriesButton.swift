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
        Button {
            action()
        } label: {
            Text(genre.capitalized)
                .padding()
                .foregroundStyle(isSelected ? .customMint : .textWhiteGrey)
                .if(isSelected) { $0.background(.customSoftDark) }
                .clipShape(.rect(cornerRadius: 12))
                .font(.custom(.montSemiBold, size: 12))
        }
        .padding(.leading)
    }
}

#Preview {
    SwitchCategoriesButton(genre: "action", isSelected: true, action: {})
        .frame(width: 150, height: 100)
        .background(.customMain)
}
