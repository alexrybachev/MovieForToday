//
//  AddToFavoritesButton.swift
//  MovieForToday
//
//  Created by Alex on 04.01.2024.
//

import SwiftUI

struct AddToFavoritesButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.primaryColor(.softDark))
                .frame(width: 32, height: 32)
                .overlay {
                    Image(.heart)
                        .colorMultiply(.red)
                }
        }
        
    }
}

#Preview {
    AddToFavoritesButton(action: {})
}
