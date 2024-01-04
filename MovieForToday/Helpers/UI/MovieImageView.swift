//
//  MovieImageView.swift
//  MovieForToday
//
//  Created by Alex on 28.12.2023.
//

import SwiftUI

struct MovieImageView: View {
    let image: Image
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let showPlayButton: Bool
    
    init(image: Image, width: CGFloat, height: CGFloat, cornerRadius: CGFloat, showPlayButton: Bool = false) {
        self.image = image
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.showPlayButton = showPlayButton
    }
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipShape(.rect(cornerRadius: cornerRadius))
            .overlay {
                if showPlayButton {
                    Image(systemName: "play.fill")
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 2)
                }
            }
            .padding([.leading, .trailing])
    }
}

#Preview {
    MovieImageView(image: Image(.topGunVert), width: 242, height: 166, cornerRadius: 8, showPlayButton: true)
}
