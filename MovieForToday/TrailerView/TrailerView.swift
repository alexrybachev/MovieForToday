//
//  TrailerView.swift
//  MovieForToday
//
//  Created by Андрей Бородкин on 10.01.2024.
//

import SwiftUI
import RemoteImage
import WebPlayer

/* TODO: - list
 1. Change Bg and FG to special view (DRY)
 2. There is a special date view instead of manual
 */
struct TrailerView: View {
    
    @Binding var movieModel: MovieModel
    @Binding var movieImages: [MovieImage]
    
    @State private var isSharing = false
    @State private var isFullScreen = false
    
    // MARK: - ViewBuilder Elements
    
    @ViewBuilder
    private var MovieInfo: some View {
        VStack (alignment: .leading, spacing: 16) {
            HeadlineView(headline: LocalizedStringKey(movieModel.name), isAddButton: false, action: {})
            
            HStack {
                ImageText(image: .calendar, text: movieModel.year)
                ImageText(image: .film, text: movieModel.genres.map { $0.capitalized }.joined(separator: ", "))
            }
            .padding([.top, .bottom])
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var MovieSynopsis: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeadlineView(headline: "story_line", isAddButton: false, action: {})
            
            Text(movieModel.description)
                .foregroundStyle(Color.textWhiteGrey)
                .font(.custom(.montRegular, size: Constants.subheadlineText))
                .padding([.leading, .trailing])
            
            HeadlineView(headline: "cast_and_crew", isAddButton: false, action: {})
        }
    }
    
    @ViewBuilder
    private var MovieCast: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(movieModel.persons) { person in
                    RemoteImage(link: person.photo) { image in
                        CrewLabelView(
                            image: image,
                            name: person.name,
                            role: person.profession
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
    }
    
    // MARK: - View
    var body: some View {
        ZStack {
            Color.customMain
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    WebPlayerView(youtybeLink: movieModel.trailerUrl)
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        .padding()
                    
                    
                    MovieInfo
                    
                    MovieSynopsis
                    
                    MovieCast
                    
                    GaleryCarouselView(
                        movieImages: $movieImages,
                        headlineTextSize: Constants.headlineText,
                        imageWidth: Constants.movieImageWidth,
                        imageHeight: Constants.movieImageHeight,
                        cornerRadius: Constants.movieImageCornerRadius
                    )
                    
                }
            }
            .padding(.bottom, Constants.tabBarHeight)
        }
        .navigationTitle(movieModel.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.customMain)
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
    
    // MARK: - Methods
}

// MARK: - Drawing
private extension TrailerView {
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
    TrailerView(
        movieModel: .constant(MovieModel.getMocData()),
        movieImages: .constant([])
    )
}
