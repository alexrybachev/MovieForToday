//
//  PlaceholderView.swift
//  MovieForToday
//
//  Created by Alex on 27.12.2023.
//

import SwiftUI

struct PlaceholderView: View {
    let name: ImageResource
    let title: String
    let subtitle: String
    
    var body: some View {
        ZStack {
            Color.customMain
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 76)
                
                Text(title)
                    .font(.custom(.montSemiBold, size: 16))
                    .foregroundStyle(.textWhiteGrey)
                
                Text(subtitle)
                    .font(.custom(.montRegular, size: 12))
                    .foregroundStyle(.textGrey)
            }
            .frame(minWidth: 252, maxHeight: 164)
            .padding([.leading, .trailing])
        }
    }
}

#Preview {
    PlaceholderView(
        name: .box,
        title: "There Is No Movie Yet!",
        subtitle: "Find your movie by Type title, categories, years, etc"
    )
    .background(.customMain)
}
