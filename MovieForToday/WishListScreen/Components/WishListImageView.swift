//
//  WishListImageView.swift
//  MovieForToday
//
//  Created by Alex on 28.12.2023.
//

import SwiftUI

struct WishListImageView: View {
    let image:Image
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipShape(.rect(cornerRadius: 8))
            .opacity(0.8)
            .overlay {
                Image(systemName: "play.fill")
                    .foregroundStyle(.white)
                    .shadow(color: .black, radius: 2)
            }
            .padding([.leading, .trailing])
    }
}

#Preview {
    WishListImageView(image: Image(.topGunVert), width: 121*2, height: 83*2)
}
