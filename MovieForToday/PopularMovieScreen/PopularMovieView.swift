//
//  PopularMovieView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct PopularMovieView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    let slug: String?
    
    var body: some View {
        ZStack {
            Color.customMain
                .ignoresSafeArea()
            
            MovieCategoryPosterCarouselView(homeViewModel: viewModel)
                .frame(height: 200)
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.slugModels) { movieModel in
                        MovieView(movieModel: movieModel)
                    }
                }
            }
            .navigationTitle("popular_movie")
        }
        .task {
            viewModel.fetchMovies(with: slug)
            viewModel.fetchMovies(viewModel.categories[viewModel.selectedCategory])
        }
    }
}

#Preview {
    PopularMovieView(viewModel: HomeViewModel(), slug: nil)
}
