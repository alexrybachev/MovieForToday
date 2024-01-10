//
//  MovieCategoryPosterCarouselView.swift
//  MovieForToday
//
//  Created by Alex on 09.01.2024.
//

import SwiftUI
import RemoteImage

struct MovieCategoryPosterCarouselView: View {
    let movieModel: MovieModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0..<3) { _ in
                    NavigationLink {
                        // TODO: PopularMovieView?
                    } label: {
                        RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
                            MovieImageView(
                                image: image,
                                width: Constants.posterWidth,
                                height: Constants.posterHeight,
                                cornerRadius: Constants.posterRadius
                            )
                            .overlay {
                                PosterLabelView(
                                    title: movieModel.name,
                                    subtitle: movieModel.category,
                                    spacing: Constants.labelSpacing
                                )
                                .offset(x: Constants.labelXoffset, y: Constants.labelYoffset)
                            }
                        } placeholder: {
                            ProgressView()
                                .frame(
                                    width: Constants.posterWidth,
                                    height: Constants.posterHeight
                                )
                        } errorHandler: { _ in
                            ErrorImageView(
                                systemName: "photo",
                                width: Constants.posterWidth,
                                height: Constants.posterHeight
                            )
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Drawing
private extension MovieCategoryPosterCarouselView {
    struct Constants {
        static let posterHeight: CGFloat = 154
        static let posterWidth: CGFloat = 295
        static let posterRadius: CGFloat = 16
        static let labelXoffset: CGFloat = -90
        static let labelYoffset: CGFloat = 30
        static let labelSpacing: CGFloat = 16
    }
}

#Preview {
    MovieCategoryPosterCarouselView(movieModel: MovieModel.getMocData())
}
