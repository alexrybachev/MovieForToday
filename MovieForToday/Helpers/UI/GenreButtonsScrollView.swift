//
//  GenreButtonsScrollView.swift
//  MovieForToday
//
//  Created by Alex on 05.01.2024.
//

import SwiftUI

struct GenreButtonsScrollView: View {
    @State private var selectedGenre: Genre? = Genre.getMockData().first
    let genres: [Genre]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres, id: \.self) { genre in
                    SwitchCategoriesButton(
                        genre: genre.name,
                        isSelected: genre == selectedGenre
                    ) {
                        selectedGenre = genre
                        // TODO: Sort
                    }
                }
            }
            .padding([.top, .bottom])
        }
    }
}

#Preview {
    GenreButtonsScrollView(genres: MovieModel.getMocData().genre)
        .background(.customMain)
}
