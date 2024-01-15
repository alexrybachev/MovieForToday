//
//  MoviePosterCarouselView.swift
//  MovieForToday
//
//  Created by Alex on 09.01.2024.
//

import SwiftUI
import RemoteImage

struct MoviePosterCarouselView: View {
    var movieModels: [MovieModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(movieModels, id: \.id) { movieModel in
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
    }
}

#Preview {
    MoviePosterCarouselView(movieModels: [MovieModel.getMocData()])
}
