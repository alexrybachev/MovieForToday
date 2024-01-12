//
//  MoviePosterCarouselView.swift
//  MovieForToday
//
//  Created by Alex on 09.01.2024.
//

import SwiftUI
import RemoteImage

struct MoviePosterCarouselView: View {
    let movieModel: MovieModel
    
    let gradient: [Color] = [
        .customSoftDark,
        .customSoftDark,
        .customSoftDark,
        .customSoftDark,
        .customSoftDark,
        .customSoftDark.opacity(0.7),
        .customSoftDark.opacity(0.5),
        .customSoftDark.opacity(0.1)
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0..<3) { _ in
                    ZStack(alignment: .bottom) {
                        // MARK: Posters
                        NavigationLink {
                            MovieDetailView(movieModel: movieModel)
                        } label: {
                            RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
                                MovieImageView(
                                    image: image,
                                    width: Constants.posterWidth,
                                    height: Constants.posterHeight,
                                    cornerRadius: Constants.posterRadius
                                )
                                .overlay {
                                    RatingView(rating: movieModel.rating, isBackground: true)
                                        .offset(
                                            x: Constants.ratingXoffset,
                                            y: Constants.ratingYoffset
                                        )
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
                        
                        // MARK: Labels
                        PosterLabelView(
                            title: movieModel.name,
                            subtitle: movieModel.category,
                            spacing: Constants.labelSpacing
                        )
                        .padding()
                        .frame(width: Constants.posterWidth)
                        .background(
                            LinearGradient(
                                colors: gradient,
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .clipShape(.rect(cornerRadius: Constants.posterRadius))
                    }
                }
            }
        }
    }
}

// MARK: - Drawing
private extension MoviePosterCarouselView {
    struct Constants {
        static let posterHeight: CGFloat = 231
        static let posterWidth: CGFloat = 135
        static let posterRadius: CGFloat = 16
        static let ratingXoffset: CGFloat = 30
        static let ratingYoffset: CGFloat = -90
        static let labelSpacing: CGFloat = 8
    }
}

#Preview {
    MoviePosterCarouselView(movieModel: MovieModel.getMocData())
}
