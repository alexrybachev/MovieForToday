//
//  WishListViewCell.swift
//  MovieForToday
//
//  Created by Alex on 27.12.2023.
//

import SwiftUI

struct WishListViewCell: View {
    let movieModel: MovieModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.rectangleCornerRadius)
                .foregroundStyle(Color.primaryColor(.softDark))
            
            HStack {
                CachedAsyncImage(url: URL(string: movieModel.urlPoster)!) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                            .padding([.leading, .trailing])
                    case .success(let image):
                        WishListImageView(
                            image: image,
                            width: Constants.imageWidth,
                            height: Constants.imageHeight
                        )
                    case .failure(_):
                        ErrorView(
                            systemName: "photo",
                            width: Constants.imageWidth,
                            height: Constants.imageHeight
                        )
                    @unknown default:
                        ErrorView(
                            systemName: "questionmark.app",
                            width: Constants.imageWidth,
                            height: Constants.imageHeight
                        )
                    }
                }
                
                VStack(alignment: .leading, spacing: Constants.verticalPaddings) {
                    Text(movieModel.genre)
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

                        Button {
                            // TODO: delete from favourites action
                        } label: {
                            Image(.heart)
                                .colorMultiply(.red)
                        }
                        .padding(.trailing, 16)
                    }
                }
            }
        }
        .frame(width: .infinity, height: Constants.rowHeight)
        .padding([.leading, .trailing])
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
        .background(Color.primaryColor(.mainDark))
}
