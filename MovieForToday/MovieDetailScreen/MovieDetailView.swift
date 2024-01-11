//
//  MovieDetailView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct MovieDetailView: View {
    @State private var isSharing = false        
    let movieModel: MovieModel
    
    var body: some View {
        ZStack {
            // MARK: Background image
            DetailBackgroundImageView(movieModel: movieModel)
            
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
                        
                        ImageText(image: .film, text: movieModel.genre.first!.name.capitalized)
                    }
                    .padding(.top)
                    .frame(maxWidth: Constants.labelsWidth)
                    
                    RatingView(rating: movieModel.rating, isBackground: true)
                    
                    // MARK: Action buttons
                    HStack {
                        NavigationLink(destination: {/* TrailerView() */}) {
                            TrailerButtonView(
                                width: Constants.buttonWidth,
                                height: Constants.buttonHeight
                            )
                        }
                        
                        Spacer()
                        
                        // TODO: Play movie button
                        ShareButtonView(image: .film, action: {})
                        
                        Spacer()
                        
                        ShareButtonView(image: .share, action: { isSharing = true })
                            .sheet(isPresented: $isSharing) {
                                // TODO: Share to..
                            }
                    }
                    .frame(maxWidth: Constants.buttonsWidth)
                    .padding(.top)
                    
                    // MARK: Text views
                    DetailTextView(
                        headlineTextSize: Constants.headlineText,
                        subheadlineTextSize: Constants.subheadlineText
                    )
                    
                    // MARK: Crew labels scroll view
                    CrewLabelsScrollView(
                        movieModel: movieModel,
                        height: Constants.circleLabelHeight
                    )
                    
                    // MARK: Galery carusel
                    GaleryCarouselView(
                        movieModel: movieModel,
                        headlineTextSize: Constants.headlineText,
                        imageWidth: Constants.movieImageWidth,
                        imageHeight: Constants.movieImageHeight,
                        cornerRadius: Constants.movieImageCornerRadius
                    )
                }
                .padding(.top)
            }
        }
        .navigationTitle(movieModel.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.customMain)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                AddToFavoritesButton(action: {})
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
