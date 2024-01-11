//
//  DetailForegroundImageView.swift
//  MovieForToday
//
//  Created by Alex on 11.01.2024.
//

import SwiftUI
import RemoteImage

struct DetailForegroundImageView: View {
    let movieModel: MovieModel
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
            MovieImageView(
                image: image,
                width: width,
                height: height,
                cornerRadius: cornerRadius
            )
        } placeholder: {
            ProgressView()
                .frame(
                    width: width,
                    height: height
                )
        } errorHandler: { _ in
            ErrorImageView(
                systemName: "photo",
                width: width,
                height: height
            )
        }
    }
}

#Preview {
    DetailForegroundImageView(movieModel: MovieModel.getMocData(), width: 205, height: 287, cornerRadius: 16)
}
