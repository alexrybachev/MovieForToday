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
    @Binding var movieImages: [MovieImage]
    
    let headlineTextSize: CGFloat
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(movieImages, id: \.previewUrl) { movieImage in
                    Button {
                        isFullScreen = true
                    } label: {
                        RemoteImage(link: movieImage.previewUrl) { image in
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
            FullScreenImageView(movieImages: $movieImages)
        }
    }
    
}

#Preview {
    GaleryCarouselView(
        movieImages: .constant([]),
        headlineTextSize: 16,
        imageWidth: 100,
        imageHeight: 101,
        cornerRadius: 16
    )
}
