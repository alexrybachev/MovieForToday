//
//  GenreButtonsScrollView.swift
//  MovieForToday
//
//  Created by Alex on 05.01.2024.
//

import SwiftUI

struct GenreButtonsScrollView: View {
    let genre: [Genre]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genre, id: \.self) { genre in
                    SwitchCategoriesButton(genre: genre.name, action: {})
                }
            }
            .padding([.top, .bottom])
        }
    }
}

#Preview {
    GenreButtonsScrollView(genre: MovieModel.getMocData().genre)
        .background(.customMain)
}
