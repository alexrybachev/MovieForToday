//
//  PlaceholderView.swift
//  MovieForToday
//
//  Created by Alex on 27.12.2023.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(.box)
                .resizable()
                .scaledToFit()
                .frame(width: 76)
            
            Text("There Is No Movie Yet!")
                .font(.custom(.montSemiBold, size: 16))
                .foregroundStyle(.textWhiteGrey)
            
            Text("Find your movie by Type title, categories, years, etc")
                .font(.custom(.montRegular, size: 12))
                .foregroundStyle(.textGrey)
        }
        .frame(minWidth: 252, maxHeight: 164)
        .padding([.leading, .trailing])
    }
}

#Preview {
    PlaceholderView()
        .background(.customMain)
}
