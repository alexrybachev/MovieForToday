//
//  VerticalPoster.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 10.01.2024.
//

import SwiftUI
import RemoteImage

struct VerticalPoster: View {
    let movieModel: MovieModel
    
    var body: some View {
        VStack {
            RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
                image
                    .resizable()
                    .frame(width: Constants.posterWidth, height: Constants.imageHeight)
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        RatingView(rating: movieModel.rating, isBackground: true)
                            .offset(
                                x: Constants.ratingXoffset,
                                y: Constants.ratingYoffset
                            )
                    }
            } placeholder: {
                ProgressView()
                    .frame(width: Constants.posterWidth, height: Constants.imageHeight)
                    .tint(.white)
            } errorHandler: { _ in
                ErrorImageView(
                    systemName: "photo",
                    width: Constants.posterWidth,
                    height: Constants.posterHeight
                )
            }
            
            VStack(alignment: .leading, spacing: Constants.labelSpacing) {
                HStack {
                    Text(movieModel.name)
                        .foregroundStyle(Color.textWhiteGrey)
                        .font(.custom(.montSemiBold, size: 14))
                    Spacer()
                }
                
                Text(movieModel.category)
                    .foregroundStyle(Color.textGrey)
                    .font(.custom(.montMedium, size: 10))
                Spacer()
            }
            .padding([.leading, .trailing], 8)
            .padding([.top, .bottom], 12)
            .frame(width: Constants.posterWidth, height: Constants.labelHeight)
        }
        .background(Color.customSoftDark)
        .frame(width: Constants.posterWidth, height: Constants.posterHeight)
        .clipShape(.rect(cornerRadius: Constants.posterRadius))
    }
}


#Preview {
    VerticalPoster(movieModel: MovieModel.getMocData())
}

// MARK: - Drawing
private extension VerticalPoster {
    struct Constants {
        static let posterHeight: CGFloat = 231
        static let posterWidth: CGFloat = 135
        static let posterRadius: CGFloat = 12
        
        static let imageHeight: CGFloat = 178
        static let labelHeight: CGFloat = 53
        
        static let ratingXoffset: CGFloat = 32
        static let ratingYoffset: CGFloat = -69
        static let labelSpacing: CGFloat = 8
    }
}
