//
//  AddToFavoritesButton.swift
//  MovieForToday
//
//  Created by Alex on 04.01.2024.
//

import SwiftUI

struct AddToFavoritesButton: View {
    @State private var isSelected = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            AddToFavoritesLabel()
                .colorMultiply(isSelected ? .red : .gray)
                .onTapGesture {
                    isSelected.toggle()
                    action()
                }
        }
        
    }
}

#Preview {
    AddToFavoritesButton(action: {})
}

struct AddToFavoritesLabel: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.customSoftDark)
            .frame(width: 32, height: 32)
            .overlay {
                Image(.heart)
                    .colorMultiply(.red)
            }
    }
}
