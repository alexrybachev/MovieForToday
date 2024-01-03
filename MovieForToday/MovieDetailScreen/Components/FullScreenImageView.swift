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
    let movieModel: MovieModel
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    ForEach(0..<5) { _ in
                        RemoteImage(url: URL(string: movieModel.urlPoster)!, configure: { $0.resizable().scaledToFit() })
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
            .background(Color.primaryColor(.mainDark))
            .toolbar {
                Button("Close", systemImage: "xmark") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    FullScreenImageView(movieModel: MovieModel.getMocData())
}
