//
//  SearchView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var searchViewModel = SearchViewModel()
    
    #warning("Удалить и Скорректировать входящий параметр moviewModel для TabBar")
    let movieModel: MovieModel = MovieModel.getMocData()
    
    var body: some View {
        ZStack {
            Color.customMain.ignoresSafeArea()
            
            VStack(spacing: 16) {
                
                CustomSearchBar(
                    searchText: $searchViewModel.searchText,
                    isSearch: $searchViewModel.isSearch,
                    placeholderText: "search_placeholder",
                    action: {
                        print("SearchBar редактируется")
                    }
                )
                
                if searchViewModel.isSearch {
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
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(searchViewModel.upcomingMovies, id: \.id) {
                                MovieView(movieModel: $0)
                            }
                        }
                    }
                    .frame(height: 147)
                    
//                    MovieView(movieModel: MovieModel.getMocData())
                    
                    Spacer()
                    
                    HeadlineView(
                        headline: "recent_movie",
                        action: {}
                    )
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 12) {
                            ForEach(0..<searchViewModel.recentMovieIds.count, id: \.self) { _ in
                                ZStack(alignment: .bottom) {
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
            searchViewModel.fetchUpcomingMovie()
            searchViewModel.fetchCategories()
            searchViewModel.getRecentMovieIds()
            print(searchViewModel.recentMovieIds)
        }
    }
}

#Preview {
    SearchView()
}
