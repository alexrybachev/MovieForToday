//
//  ShareButtonView.swift
//  MovieForToday
//
//  Created by Alex on 02.01.2024.
//

import SwiftUI

struct ShareButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(.share)
                .padding(5)
        }
        .buttonStyle(.bordered)
        .colorMultiply(Color.primaryColor(.mint))
        .clipShape(Circle())
    }
}

#Preview {
    ShareButtonView(action: {})
}
