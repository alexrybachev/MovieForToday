//
//  PopularMovieView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct PopularMovieView: View {
    let slug: String?
    let movies: [MovieModel]
    let onAppear: () -> Void
    
    var body: some View {
        ZStack {
            Color.customMain
                .ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    ForEach(movies) { movieModel in
                        MovieView(movieModel: movieModel)
                    }
                }
            }
            .navigationTitle("popular_movie")
        }
        .onAppear(perform: onAppear)
    }
}

#Preview {
    PopularMovieView(
        slug: nil,
        movies: [],
        onAppear: {}
    )
}
