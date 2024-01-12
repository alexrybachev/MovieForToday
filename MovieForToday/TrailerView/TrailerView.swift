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
    
    @State private var isSharing = false
    @State private var isFullScreen = false
    let gradient = [
        Color.primaryColor(.mainDark),
        Color.primaryColor(.mainDark).opacity(0),
        Color.primaryColor(.mainDark),
        Color.primaryColor(.mainDark),
        Color.primaryColor(.mainDark)
    ]
    
    let movieModel: MovieModel
    
    // MARK: - ViewBuilder Elements

    @ViewBuilder private var Trailer: some View {
        Rectangle()
            .frame(width: 200, height: 200)
            .background(Color.white)
    }
    
    @ViewBuilder private var MovieInfo: some View {
        VStack (alignment: .leading, spacing: 16){
            Text(movieModel.name)
                .foregroundStyle(Color.textColor(.whiteGrey))
                .font(.custom(.montSemiBold, size: Constants.headlineText))
            HStack{
                ImageText(image: .calendar, text: "Release Date")
                Text(movieModel.year) //TODO: full date
                    .foregroundStyle(Color.textWhiteGrey)
                Divider()
                
                ImageText(image: .film, text: movieModel.genre.first!.name.capitalized)
                Spacer()
            }
            .padding(.top)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder private var MovieSynopsis: some View {
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
    }
    
    @ViewBuilder private var MovieCast: some View {
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
    }
    
    @ViewBuilder private var MovieGallery: some View {
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
        // MARK: - View
        var body: some View {
            ZStack {
                
                LinearGradient(colors: gradient, startPoint: .top, endPoint: .bottom)
                
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
    TrailerView(movieModel: MovieModel.getMocData())
}
