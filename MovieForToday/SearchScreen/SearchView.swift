//
//  SearchView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var searchViewModel = SearchViewModel()
    @State var isSearchText = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customMain.ignoresSafeArea()
                
                VStack(spacing: 16) {
                    
                    CustomSearchBar(
                        searchText: $searchViewModel.searchText,
                        isSearch: $searchViewModel.isSearch,
                        placeholderText: "search_placeholder",
                        action: { searchText in
                            if searchText.isEmpty {
                                isSearchText = false
                            } else {
                                isSearchText = true
                                searchViewModel.fetchMovies(with: searchText)
                                searchViewModel.fetchPersons(with: searchText)
                            }
                        }
                    )
                    
                    if isSearchText {
                        if !searchViewModel.persons.isEmpty {
                            HeadlineView(headline: "Actors", isAddButton: false, action: {})
                            
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(searchViewModel.persons) { person in
                                        PersonView(moviePerson: person)
                                    }
                                }
                            }
                            .frame(height: 87)
                        }
                        
                        HeadlineView(headline: "Movie Related", isAddButton: true, action: {})
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(searchViewModel.movieModels) { movieModel in
                                    NavigationLink {
                                        MovieDetailView(movieModel: movieModel)
                                    } label: {
                                        MovieView(movieModel: movieModel)
                                    }
                                }
                            }
                        }
                    } else {
                        
                        GenreButtonsScrollView(
                            selectedCategory: $searchViewModel.selectedCategory,
                            categories: $searchViewModel.categories,
                            action: { category in
                                searchViewModel.fetchMovies(category)
                            }
                        )
                        
                        HeadlineView(
                            headline: "upcoming_movie",
                            isAddButton: false,
                            action: {}
                        )
                        
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(searchViewModel.upcomingMovies) {
                                    MovieView(movieModel: $0)
                                }
                            }
                            .padding(.bottom, 0)
                        }
                        
                        HeadlineView(
                            headline: "recent_movie",
                            action: {}
                        )
                        .padding(.top, 12)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 12) {
                                ForEach(searchViewModel.recentMovies) { movieModel in
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
        }
        .task {
            //            searchViewModel.fetchUpcomingMovie()
            //            searchViewModel.fetchCategories()
            //            searchViewModel.getRecentMovieIds()
        }
    }
}

#Preview {
    SearchView()
}
