//
//  SearchView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    #warning("Удалить и Скорректировать входящий параметр moviewModel для TabBar")
    let movieModel: MovieModel = MovieModel.getMocData()
    
    var body: some View {
        ZStack {
            Color.customMain.ignoresSafeArea()
            
            VStack(spacing: 16) {
                
                CustomSearchBar(
                    searchText: $viewModel.searchText,
                    isSearch: $viewModel.isSearch,
                    placeholderText: "search_placeholder",
                    action: {
                        print("SearchBar редактируется")
                    }
                )
                
                if viewModel.isSearch {
//                    ScrollView(axis: .vertical) {
//                        LazyVStack {
//                            
//                        }
//                    }
                #warning("доработать с перестройкой лайаута")
                    
                } else {
                    
                    //                GenreButtonsScrollView(
                    //                    genres: $viewModel.categories,
                    //                    selectedTag: $viewModel.selectedTag
                    //                )
                    
                    HeadlineView(
                        headline: "upcoming_movie",
                        isAddButton: false,
                        action: {}
                    )
                    
                    #warning("Скорректировать MoviewView для переиспользования")
                    MovieView(movieModel: MovieModel.getMocData())
                    
                    Spacer()
                    
                    HeadlineView(
                        headline: "recent_movie",
                        action: {}
                    )
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 12) {
                            ForEach(0..<3) { _ in
                                ZStack(alignment: .bottom) {
                                    // MARK: Posters
                                    NavigationLink {
                                        MovieDetailView(movieModel: movieModel)
                                    } label: {
                                        VerticalPoster(movieModel: movieModel)
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: 231)
                    
                    Spacer()
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchCategories()
        }
    }
}

#Preview {
    SearchView()
}
