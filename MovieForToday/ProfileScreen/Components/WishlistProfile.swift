//
//  WishlistProfile.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 1/12/24.
//

import SwiftUI

struct WishlistProfile: View {
    var body: some View {
        NavigationSettings(imageIcon: "download", textNavigation: "Wishlist", destination: WishListView())
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 1.0)
                    .opacity(0.2)
            }
            .padding(.horizontal, 24)
    }
}

#Preview {
    WishlistProfile()
}
