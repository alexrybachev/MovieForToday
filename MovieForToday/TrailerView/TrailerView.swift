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
    
    @State private var isSharing = false
    @State private var isFullScreen = false
    
    // MARK: - ViewBuilder Elements

//    @ViewBuilder 
//    private var Trailer: some View {
//        Rectangle()
//            .frame(width: 200, height: 200)
//            .background(Color.white)
//    }
    
    @ViewBuilder 
    private var MovieInfo: some View {
        VStack (alignment: .leading, spacing: 16) {
            HeadlineView(headline: LocalizedStringKey(movieModel.name), isAddButton: false, action: {})

            HStack {
                ImageText(image: .calendar, text: movieModel.year)
                ImageText(image: .film, text: movieModel.genres.map { $0.capitalized}.joined(separator: ", "))
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
                // TODO: временное решение
                ForEach(0..<5) { _ in
                    RemoteImage(link: movieModel.urlPoster) { image in
                        CrewLabelView(
                            image: image,
                            name: movieModel.name,
                            role: ""
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
    
    @ViewBuilder 
    private var MovieGallery: some View {
        VStack {
            HeadlineView(headline: "galery", isAddButton: false, action: {})
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<5) { _ in
                        Button {
                            isFullScreen = true
                        } label: {
                            RemoteImage(link: movieModel.urlPoster) { image in
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
    }
        // MARK: - View
        var body: some View {
            ZStack {
                Color.customMain
                    .ignoresSafeArea()

                ScrollView {
                    VStack {
                        WebPlayerView(youtybeLink: "https://www.youtube.com/watch?v=xcE3MIHuuhg&themeRefresh=1")
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                            .padding()
                        
                        
//                        Trailer
                        
                        MovieInfo
                        
                        MovieSynopsis
                        
                        MovieCast
                        
                        MovieGallery
                        
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
    TrailerView(movieModel: .constant(MovieModel.getMocData()))
}
