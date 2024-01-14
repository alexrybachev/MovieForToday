//
//  MovieView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 24.12.2023.
//

import SwiftUI
import RemoteImage

struct MovieView: View {
    
    let movieModel: MovieModel
    
    var body: some View {
        HStack(spacing: Constants.horizontalSpacing) {
            RemoteImage(link: movieModel.urlPoster) { image in
                ZStack {
                    MovieImageView(
                        image: image,
                        width: Constants.widthImage,
                        height: Constants.heightImage,
                        cornerRadius: 8
                    )
                    
                    RatingView(rating: movieModel.rating, isBackground: true)
                        .offset(x: Constants.xPosition, y: Constants.yPosition)
                }
            } placeholder: {
                ProgressView()
                    .frame(width: Constants.widthImage, height: Constants.heightImage)
                    .padding([.leading, .trailing])
            } errorHandler: { _ in
                ErrorImageView(
                    systemName: "photo",
                    width: Constants.widthImage,
                    height: Constants.heightImage
                )
            }
            
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                Spacer()
                
                Text(movieModel.name)
                    .font(.custom(.montSemiBold, size: 16))
                    .foregroundStyle(Color.white)
                
                ImageText(image: .calendar,
                          text: movieModel.year)
                
                HStack {
                    ImageText(image: .clock,
                              text: movieModel.duration,
                              isMinutes: true)
                    pgRating
                }
                
                HStack(spacing: 8) {
                    
                    ImageText(image: .film,
                              text: movieModel.genres.first!.capitalized)
                    
                    Divider()
                        .background(Color.white)
                    
                    Text(movieModel.genres.joined(separator: ", "))
                        .font(.custom(.montMedium, size: 12))
                        .foregroundStyle(Color.white)
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .background(Color.customMain)
        .frame(height: Constants.heightImage)
    }
}

// MARK: - PG rating

private extension MovieView {
    @ViewBuilder
    var pgRating: some View {
        Text("PG-13")
            .font(.custom(.montMedium, size: 12))
            .foregroundStyle(Color.customMint)
            .padding([.leading, .trailing], 4)
            .padding([.top, .bottom], 6)
            .overlay {
                RoundedRectangle(cornerRadius: 3)
                    .stroke(.customMint)
            }
    }
}

// MARK: - Drawing Constants

private extension MovieView {
    struct Constants {
        static let horizontalSpacing: CGFloat = 13
        static let verticalSpacing: CGFloat = 12
        static let widthImage: CGFloat = 112
        static let heightImage: CGFloat = 147
        static let xPosition: CGFloat = -20.5
        static let yPosition: CGFloat = -53.5
    }
}

#Preview {
    MovieView(movieModel: MovieModel.getMocData())
}

