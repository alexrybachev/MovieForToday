//
//  ShareButtonImage.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 14.01.2024.
//

import SwiftUI

struct ShareButtonImage: View {
    let image: ImageResource
    
    var body: some View {
        Image(image)
            .padding(5)
            .colorMultiply(.customMint)
            .clipShape(Circle())
    }
}

#Preview {
    ShareButtonImage(image: .film)
}
