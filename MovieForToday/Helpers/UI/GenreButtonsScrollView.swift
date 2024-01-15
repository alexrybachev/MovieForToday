//
//  GenreButtonsScrollView.swift
//  MovieForToday
//
//  Created by Alex on 05.01.2024.
//

import SwiftUI

struct GenreButtonsScrollView: View {
    let genres: [String]
    let selectedGenre: String
    var action: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres, id: \.self) { genre in
                    SwitchCategoriesButton(
                        genre: genre,
                        isSelected: selectedGenre == genre,
                        action: { action(genre) }
                    )
                }
            }
            .padding([.top, .bottom])
        }
    }
}

#Preview {
    GenreButtonsScrollView(
        genres: ["All", "Action", "Boevik"], 
        selectedGenre: "All",
        action: { _ in }
    )
    .background(Color.customMain)
}
