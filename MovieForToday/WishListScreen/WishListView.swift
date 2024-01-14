//
//  WishListView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct WishListView: View {
    @StateObject var viewModel = WishListViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.movieModels.isEmpty {
                PlaceholderView(
                    name: .box,
                    title: "There Is No Movie Yet!",
                    subtitle: "Find your movie by Type title, categories, years, etc"
                )
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.movieModels) { movie in
                        NavigationLink {
                            MovieDetailView(movieModel: movie)
                        } label: {
                            WishListViewCell(movieModel: movie)
                        }
                    }
                }
            }
        }
        .task {
            print("task start")
            viewModel.getFavoriteMovies()
        }
        .navigationTitle("wishlist")
        .navigationBarTitleDisplayMode(.inline)
        .background(.customMain)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton()
            }
        }
    }
}

#Preview {
    WishListView()
}
