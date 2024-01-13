//
//  PopularMovieView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct PopularMovieView: View {
    
    @StateObject var viewModel = PopularMovieViewModel()
    
    var body: some View {
        ZStack {
            Color.customMain
                .ignoresSafeArea()
            
//            MovieCategoryPosterCarouselView(homeViewModel: homeViewModel)
//                .frame(height: 200)
            
            ScrollView {
                ForEach(0..<20) { _ in
                    MovieView(movieModel: viewModel.movieModels.first!)
                }
            }
            .navigationTitle("popular_movie")
        }
    }
}

#Preview {
    PopularMovieView()
}
