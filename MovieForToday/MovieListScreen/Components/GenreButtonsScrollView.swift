//
//  GenreButtonsScrollView.swift
//  MovieForToday
//
//  Created by Alex on 05.01.2024.
//

import SwiftUI

struct GenreButtonsScrollView: View {
    
    @Binding var genres: [String]
    @Binding var selectedTag: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0..<genres.count, id: \.self) { index in
                    SwitchCategoriesButton(
                        selectedTag: $selectedTag,
                        id: index,
                        genre: genres[index],
                        action: {}
                    )
                }
            }
            .frame(height: 39)
        }
    }
}

#Preview {
    GenreButtonsScrollView(
        genres: .constant(MovieModel.getMocData().genres),
        selectedTag: .constant(1)
    )
    .background(Color.customMain)
}
