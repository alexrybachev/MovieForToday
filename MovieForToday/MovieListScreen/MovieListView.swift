//
//  MovieListView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct MovieListView: View {
    let movieModel: MovieModel
    
    var body: some View {
        ZStack {
            VStack {
                // Buttons
//                GenreButtonsScrollView(genres: movieModel.genres)
                
                // Posters
                NavigationLink {
                    // TODO: PopularMovieView()?
                } label: {
                    PosterScrollView(genres: movieModel.genres, urlPoster: movieModel.urlPoster)
                }

            }
        }
        .navigationTitle("movie_lists")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.primaryColor(.mainDark))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton()
            }
        }
    }
}

#Preview {
    MovieListView(movieModel: MovieModel.getMocData())
}
