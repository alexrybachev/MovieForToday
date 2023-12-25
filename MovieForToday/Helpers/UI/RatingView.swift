//
//  RatingView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 24.12.2023.
//

import SwiftUI

struct RatingView: View {
    let rating: String
    var isBackground: Bool = false
    
    var body: some View {
        
        HStack(spacing: 4) {
            Image(.star)
                .resizable()
                .frame(width: 16, height: 16)
                .colorMultiply(.customOrange)
            Text(rating)
                .font(.custom(.montSemiBold, size: 12))
                .foregroundStyle(Color.customOrange)
        }
        .padding([.leading, .trailing], 8)
        .padding([.top, .bottom], 4.5)
        .if(isBackground, transform: { view in
            view
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        })
    }
}

#Preview("true") {
    ZStack {
        Image(.topGunVert)
            .aspectRatio(contentMode: .fill)
        RatingView(rating: "4.5", isBackground: true)
    }
}

#Preview("false") {
    ZStack {
        Image(.topGunVert)
            .aspectRatio(contentMode: .fill)
        RatingView(rating: "4.5", isBackground: false)
    }
}
