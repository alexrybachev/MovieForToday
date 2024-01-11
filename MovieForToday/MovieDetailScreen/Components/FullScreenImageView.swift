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
    let movieModel: MovieModel
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selected) {
                    ForEach(0..<5) { _ in
                        RemoteImage(
                            url: URL(string: movieModel.urlPoster)!,
                            configure: { $0.resizable().scaledToFit() }
                        )
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                PagingIndexView(numberOfItems: 5, selectedTab: selected)
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
    FullScreenImageView(movieModel: MovieModel.getMocData())
}
