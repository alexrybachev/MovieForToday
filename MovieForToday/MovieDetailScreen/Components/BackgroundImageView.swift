//
//  BackgroundImageView.swift
//  MovieForToday
//
//  Created by Alex on 02.01.2024.
//

import SwiftUI

struct BackgroundImageView: View {
    let image: Image
    let gradient: [Color]
    let blur: Double
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity, alignment: .top)
            .opacity(0.2)
            .blur(radius: blur)
            .overlay {
                LinearGradient(colors: gradient, startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundImageView(image: Image(.topGunVert), gradient: [], blur: 0)
}
