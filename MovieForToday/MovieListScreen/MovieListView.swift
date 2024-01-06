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
                GenreButtonsScrollView(genre: movieModel.genre)
                
                // Posters
                PosterScrollView(genre: movieModel.genre, urlPoster: movieModel.urlPoster)
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
