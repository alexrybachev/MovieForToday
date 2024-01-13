//
//  DetailBackgroundImageView.swift
//  MovieForToday
//
//  Created by Alex on 11.01.2024.
//

import SwiftUI
import RemoteImage

struct DetailBackgroundImageView: View {
    let movieModel: MovieModel
    let gradient: [Color] = [
        .customMain,
        .customMain.opacity(0),
        .customMain,
        .customMain,
        .customMain
    ]
    
    var body: some View {
        RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
            BackgroundImageView(image: image, gradient: gradient, blur: 1)
        } placeholder: {
            BackgroundImageView(image: Image(.topGunVert), gradient: gradient, blur: 10)
        } errorHandler: { _ in
            BackgroundImageView(image: Image(.topGunVert), gradient: gradient, blur: 20)
        }
    }
}

#Preview {
    DetailBackgroundImageView(movieModel: MovieModel.getMocData())
}
