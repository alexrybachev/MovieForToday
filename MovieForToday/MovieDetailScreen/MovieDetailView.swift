//
//  MovieDetailView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import WebPlayer

struct MovieDetailView: View {
    
    @StateObject private var movieDetail = MovieDetailViewModel()
    
    @State private var isSharing = false
    
    let movieModel: MovieModel
    
    var body: some View {
        ZStack {
            // MARK: Background image
            DetailBackgroundImageView(movieModel: $movieDetail.movieModel)
            
            ScrollView {
                VStack {
                    // MARK: Foreground image
                    DetailForegroundImageView(
                        movieModel: movieModel,
                        width: Constants.imageWidth,
                        height: Constants.imageHeight,
                        cornerRadius: Constants.movieImageCornerRadius
                    )
                    
                    // MARK: Labels and rating
                    HStack {
                        ImageText(image: .calendar, text: movieModel.year)
                        Divider()
                        
                        ImageText(image: .clock, text: movieModel.duration, isMinutes: true)
                        Divider()
                        
                        ImageText(image: .film, text: movieModel.genres.joined(separator: ", "))
                    }
                    .padding([.top, .leading, .trailing])
                    .onTapGesture {
                        print("\nURL video:\n", movieDetail.movieModel.trailerUrl)
                    }
                    
                    // MARK: - Rating
                    RatingView(rating: movieModel.rating, isBackground: true)
                    
                    // MARK: Action buttons
                    HStack {
                        NavigationLink(destination: { TrailerView(movieModel: $movieDetail.movieModel, movieImages: $movieDetail.movieImages)}) {
                            TrailerButtonView(
                                width: Constants.buttonWidth,
                                height: Constants.buttonHeight
                            )
                        }
                        
                        Spacer()
                        
                        // TODO: Play movie button
                        NavigationLink {
                            WebPlayerView(movieId: String(movieModel.id))
                        } label: {
                            ShareButtonImage(image: .film)
                        }
                        
                        Spacer()
                        
                        ShareButtonView(image: .share, action: { isSharing = true })
                            .sheet(isPresented: $isSharing) {
                                // TODO: Share to..
                                #warning("TODO: Share to..")
                            }
                    }
                    .frame(maxWidth: Constants.buttonsWidth)
                    .padding(.top)
                    
                    HeadlineView(headline: "story_line", isAddButton: false ,action: {})
                        .padding(.top)
                    
                    DetailTextView(
                        descriptionMovie: movieModel.description,
                        headlineTextSize: Constants.headlineText,
                        subheadlineTextSize: Constants.subheadlineText
                    )
                    
                    HeadlineView(headline: "cast_and_crew", isAddButton: false ,action: {})
                    
                    // MARK: Crew labels scroll view
                    CrewLabelsScrollView(
                        movieModel: $movieDetail.movieModel,
                        height: Constants.circleLabelHeight
                    )
                    
                    HeadlineView(headline: "galery", isAddButton: false ,action: {})
                    
                    // MARK: Galery carusel
                    GaleryCarouselView(
                        movieImages: $movieDetail.movieImages,
                        headlineTextSize: Constants.headlineText,
                        imageWidth: Constants.movieImageWidth,
                        imageHeight: Constants.movieImageHeight,
                        cornerRadius: Constants.movieImageCornerRadius
                    )
                }
                .padding(.top)
            }
        }
        .task {
            movieDetail.fetchMovieDetail(for: movieModel.id)
            movieDetail.fetchMovieImages(for: movieModel.id)
        }
        .onAppear {
            movieDetail.saveRecentMovie(with: movieModel.id)
        }
        .navigationTitle(movieDetail.movieModel.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.customMain)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                AddToFavoritesButton(action: {
                    print("add button tapped")
                    movieDetail.saveFavoriteMovie(with: movieModel.id)
                })
            }
        }
    }
}

// MARK: - Drawing
private extension MovieDetailView {
    struct Constants {
        static let imageHeight: CGFloat = 287
        static let imageWidth: CGFloat = 205
        static let radius: CGFloat = 12
        static let labelsWidth: CGFloat = 274
        static let buttonHeight: CGFloat = 48
        static let buttonWidth: CGFloat = 115
        static let buttonsWidth: CGFloat = 234
        static let headlineText: CGFloat = 16
        static let subheadlineText: CGFloat = 14
        static let circleLabelHeight: CGFloat = 40
        static let movieImageHeight: CGFloat = 101
        static let movieImageWidth: CGFloat = 100
        static let movieImageCornerRadius: CGFloat = 8
    }
}

#Preview {
    NavigationView {
        MovieDetailView(movieModel: MovieModel.getMocData())
    }
}
