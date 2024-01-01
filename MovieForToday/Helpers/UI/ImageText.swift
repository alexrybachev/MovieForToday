//
//  ImageText.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 24.12.2023.
//

import SwiftUI

struct ImageText: View {
    let image: ImageResource
    let text: String
    var color: Color = .textGrey
    var isMinutes: Bool = false
    
    var body: some View {
        HStack {
            Image(image)
                .colorMultiply(color)
            HStack(spacing: 5) {
                Text(text)
                if isMinutes == true {
                    Text("minutes")
                }
            }
            .font(.custom(.montMedium, size: 12))
            .foregroundColor(color)
        }
    }
}

#Preview {
    ImageText(image: .clock, text: "145", isMinutes: true)
}
