//
//  GenreButtonsScrollView.swift
//  MovieForToday
//
//  Created by Alex on 05.01.2024.
//

import SwiftUI

struct GenreButtonsScrollView: View {
    @Binding var selectedCategory: Int
    @Binding var categories: [String]
    var action: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<categories.count, id: \.self) { index in
                    SwitchCategoriesButton(
                        selectedTag: $selectedCategory,
                        id: index,
                        genre: categories[index],
                        action: {
                            print("selected category: ", categories[index])
                            #warning("TODO: Sort")
                            action(categories[index])
                        }
                    )
                }
            }
            .padding([.top, .bottom])
        }
    }
}

#Preview {
    GenreButtonsScrollView(
        selectedCategory: .constant(0),
        categories: .constant(["All", "Action", "Boevik"]),
        action: { _ in }
    )
    .background(Color.customMain)
}
