//
//  TrailerButtonView.swift
//  MovieForToday
//
//  Created by Alex on 02.01.2024.
//

import SwiftUI

struct TrailerButtonView: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Label("trailer", systemImage: "play.fill")
            .frame(width: width, height: height)
            .foregroundStyle(.white)
            .background(Color.primaryColor(.orange))
            .clipShape(Capsule())
    }
}

#Preview {
    TrailerButtonView(width: 200, height: 100)
}
