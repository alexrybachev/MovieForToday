//
//  PosterScrollView.swift
//  MovieForToday
//
//  Created by Alex on 05.01.2024.
//

import SwiftUI
import RemoteImage

struct PosterScrollView: View {
    let genres: [String]
    let urlPoster: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(genres, id: \.self) { genre in
                LazyVStack {
                    RemoteImage(url: URL(string: urlPoster)!) { image in
                        MovieImageView(
                            image: image,
                            width: Constants.posterWidth,
                            height: Constants.posterHeight,
                            cornerRadius: Constants.posterRadius,
                            showPlayButton: true
                        )
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
                    
                    HStack {
                        Text(genre.capitalized)
                            .foregroundStyle(Color.textColor(.whiteGrey))
                            .font(.custom(.montSemiBold, size: Constants.titleSize))
                            .padding(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 0))
                        
                        Spacer()
                    }
                }
            }
            .padding(.bottom, Constants.tabBarHeight)
        }
    }
}

// MARK: - Drawing
private extension PosterScrollView {
    struct Constants {
        static let posterHeight: CGFloat = 168
        static let posterWidth: CGFloat = .infinity
        static let posterRadius: CGFloat = 16
        static let tabBarHeight: CGFloat = 72
        static let titleSize: CGFloat = 16
    }
}

#Preview {
    PosterScrollView(
        genres: MovieModel.getMocData().genres,
        urlPoster: MovieModel.getMocData().urlPoster
    )
        .background(Color.customMain)
}
