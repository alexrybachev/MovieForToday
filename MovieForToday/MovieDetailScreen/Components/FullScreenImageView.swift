//
//  FullScreenImageView.swift
//  MovieForToday
//
//  Created by Alex on 03.01.2024.
//

import SwiftUI
import RemoteImage

struct FullScreenImageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selected = 0
    @Binding var movieImages: [MovieImage]
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selected) {
                    ForEach(movieImages, id: \.previewUrl) { movieImage in
                        RemoteImage(
                            link: movieImage.previewUrl,
                            configure: { $0.resizable().scaledToFit() }
                        )
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                PagingIndexView(numberOfItems: movieImages.count, selectedTab: $selected)
                    .animation(.default, value: selected)
            }
            .background(.customMain)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.customMint)
                }
            }
        }
    }
}

#Preview {
    FullScreenImageView(movieImages: .constant([]))
}
