//
//  ShareButtonView.swift
//  MovieForToday
//
//  Created by Alex on 02.01.2024.
//

import SwiftUI

struct ShareButtonView: View {
    let image: ImageResource
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(image)
                .padding(5)
        }
        .buttonStyle(.bordered)
        .colorMultiply(.customMint)
        .clipShape(Circle())
    }
}

#Preview {
    ShareButtonView(image: .share, action: {})
}
