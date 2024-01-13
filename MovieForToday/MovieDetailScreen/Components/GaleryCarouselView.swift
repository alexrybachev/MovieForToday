//
//  GaleryCarouselView.swift
//  MovieForToday
//
//  Created by Alex on 11.01.2024.
//

import SwiftUI
import RemoteImage

struct GaleryCarouselView: View {
    @State private var isFullScreen = false
    @Binding var movieModel: MovieModel
    
    let headlineTextSize: CGFloat
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                // TODO: Don't forget!
                ForEach(0..<5) { _ in
                    Button {
                        isFullScreen = true
                    } label: {
                        RemoteImage(link: movieModel.urlPoster) { image in
                            MovieImageView(
                                image: image,
                                width: imageWidth,
                                height: imageHeight,
                                cornerRadius: cornerRadius
                            )
                        } placeholder: {
                            ProgressView()
                                .frame(
                                    width: imageWidth,
                                    height: imageHeight
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

#Preview {
    GaleryCarouselView(
        movieModel: .constant(MovieModel.getMocData()),
        headlineTextSize: 16,
        imageWidth: 100,
        imageHeight: 101,
        cornerRadius: 16
    )
}
