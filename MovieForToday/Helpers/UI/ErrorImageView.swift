//
//  ErrorImageView.swift
//  MovieForToday
//
//  Created by Alex on 28.12.2023.
//

import SwiftUI

struct ErrorImageView: View {
    let systemName: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .foregroundStyle(.textDarkGrey)
            .opacity(0.5)
            .frame(width: width, height: height)
            .padding([.leading, .trailing])
    }
}

#Preview {
    ErrorImageView(systemName: "photo", width: 50, height: 50)
}
