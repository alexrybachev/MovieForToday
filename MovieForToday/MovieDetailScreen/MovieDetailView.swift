//
//  MovieDetailView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import RemoteImage

struct MovieDetailView: View {
    @State private var isSharing = false
    @State private var isFullScreen = false
    @State private var gradient = [
        Color.primaryColor(.mainDark),
        Color.primaryColor(.mainDark).opacity(0),
        Color.primaryColor(.mainDark),
        Color.primaryColor(.mainDark),
        Color.primaryColor(.mainDark)
    ]
    
    let movieModel: MovieModel
    
    var body: some View {
        ZStack {
            // MARK: Background image
            RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
                BackgroundImageView(image: image, gradient: gradient, blur: 1)
            } placeholder: {
                BackgroundImageView(image: Image(.topGunVert), gradient: gradient, blur: 10)
            } errorHandler: { _ in
                BackgroundImageView(image: Image(.topGunVert), gradient: gradient, blur: 20)
            }
            
            ScrollView {
                VStack {
                    // MARK: Foreground image
                    RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
                        MovieImageView(
                            image: image,
                            width: Constants.imageWidth,
                            height: Constants.imageHeight,
                            cornerRadius: Constants.radius
                        )
                    } placeholder: {
                        ProgressView()
                            .frame(
                                width: Constants.imageWidth,
                                height: Constants.imageHeight
                            )
                    } errorHandler: { _ in
                        ErrorImageView(
                            systemName: "photo",
                            width: Constants.imageWidth,
                            height: Constants.imageHeight
                        )
                    }
                    .padding(.top)
                    
                    // MARK: Labels
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
                        .padding(.bottom, 24)
                    
                    // MARK: Action buttons
                    HStack {
                        NavigationLink(destination: {/* TrailerView() */}) {
                            TrailerButtonView(
                                width: Constants.buttonWidth,
                                height: Constants.buttonHeight
                            )
                        }
                        
                        Spacer()
                        
                        ShareButtonView(action: { isSharing = true })
                            .sheet(isPresented: $isSharing) {
                                // TODO: Share to..
                            }
                    }
                    .frame(maxWidth: Constants.buttonsWidth)
                    
                    // MARK: Text views
                    VStack(alignment: .leading, spacing: 16) {
                        Text("story_line")
                            .foregroundStyle(Color.textColor(.whiteGrey))
                            .font(.custom(.montSemiBold, size: Constants.headlineText))
                        
                        Text("For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. More")
                            .foregroundStyle(Color.textColor(.whiteGrey))
                            .font(.custom(.montRegular, size: Constants.subheadlineText))
                            .padding(.bottom)
                        
                        Text("cast_and_crew")
                            .foregroundStyle(Color.textColor(.whiteGrey))
                            .font(.custom(.montSemiBold, size: Constants.headlineText))
                    }
                    .padding()
                    
                    // MARK: Crew labels scroll view
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            // TODO: временное решение
                            ForEach(0..<5) { _ in
                                RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
                                    CrewLabelView(
                                        image: image,
                                        name: movieModel.name,
                                        role: movieModel.genre.first!.name.capitalized
                                    )
                                } placeholder: {
                                    ProgressView()
                                        .frame(
                                            width: Constants.circleLabelHeight,
                                            height: Constants.circleLabelHeight
                                        )
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    // MARK: Galery carusel
                    HStack {
                        Text("galery")
                            .foregroundStyle(Color.textColor(.whiteGrey))
                            .font(.custom(.montSemiBold, size: Constants.headlineText))
                        
                        Spacer()
                    }
                    .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<5) { _ in
                                Button {
                                    isFullScreen = true
                                } label: {
                                    RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
                                        MovieImageView(
                                            image: image,
                                            width: Constants.movieImageWidth,
                                            height: Constants.movieImageHeight,
                                            cornerRadius: Constants.movieImageCornerRadius
                                        )
                                    } placeholder: {
                                        ProgressView()
                                            .frame(
                                                width: Constants.movieImageWidth,
                                                height: Constants.movieImageHeight
                                            )
                                    }
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $isFullScreen) {
                        FullScreenImageView(movieModel: movieModel)
                    }
                }
                .padding(.bottom, Constants.tabBarHeight)
            }
        }
        .navigationTitle(movieModel.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.primaryColor(.mainDark))
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
        static let tabBarHeight: CGFloat = 72
    }
}

#Preview {
    MovieDetailView(movieModel: MovieModel.getMocData())
}
