//
//  WishListViewCell.swift
//  MovieForToday
//
//  Created by Alex on 27.12.2023.
//

import SwiftUI
import RemoteImage

struct WishListViewCell: View {
    let movieModel: MovieModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.rectangleCornerRadius)
                .foregroundStyle(.customSoftDark)
            
            HStack {
                RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
                    MovieImageView(
                        image: image,
                        width: Constants.imageWidth,
                        height: Constants.imageHeight, 
                        cornerRadius: 8,
                        showPlayButton: true
                    )
                } placeholder: {
                    ProgressView()
                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                        .padding([.leading, .trailing])
                } errorHandler: { _ in
                    ErrorImageView(
                        systemName: "photo",
                        width: Constants.imageWidth,
                        height: Constants.imageHeight
                    )
                }
                
                VStack(alignment: .leading, spacing: Constants.verticalPaddings) {
                    Text(movieModel.genres.first!.capitalized)
                        .font(.custom(.montMedium, size: Constants.smallTextSize))
                        .foregroundStyle(.textWhiteGrey)
                    
                    Text(movieModel.name)
                        .font(.custom(.montSemiBold, size: Constants.largeTextSize))
                        .foregroundStyle(.textWhiteGrey)
                    
                    HStack {
                        Text(movieModel.category)
                            .font(.custom(.montRegular, size: Constants.smallTextSize))
                            .foregroundStyle(.textGrey)
                        
                        RatingView(rating: movieModel.rating)
                        
                        Spacer()
                        
                        // TODO: Add to wishlist
                        AddToFavoritesButton(action: {})
                            .padding(.trailing, 16)
                    }
                }
            }
        }
        .frame(width: .infinity, height: Constants.rowHeight)
        .padding([.leading, .trailing, .top])
    }
}

// MARK: - Drawing
private extension WishListViewCell {
    struct Constants {
        static let rowHeight: CGFloat = 107
        static let rectangleCornerRadius: CGFloat = 16
        static let smallTextSize: CGFloat = 12
        static let largeTextSize: CGFloat = 14
        static let verticalPaddings: CGFloat = 8
        static let imageHeight: CGFloat = 83
        static let imageWidth: CGFloat = 121
    }
}

// MARK: - Preview
#Preview {
    WishListViewCell(movieModel: MovieModel.getMocData())
        .background(.customMain)
}
