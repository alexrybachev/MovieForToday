//
//  HomeView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = PopularMovieViewModel()
    @State private var searchText = ""
    @State private var isSearch = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        // MARK: CustomSearchBar
                        CustomSearchBar(
                            searchText: $searchText,
                            isSearch: $isSearch,
                            placeholderText: "search_a_title..", 
                            action: {}
                        )
                        .padding(EdgeInsets(top: 26, leading: 16, bottom: 26, trailing: 16))
                        
                        // MARK: Movie category poster carousel
                        MovieCategoryPosterCarouselView(movieModel: viewModel.movieModels.first!)
                            .padding(.bottom, 30)
                        
                        // MARK: Headlines and Buttons
                        HeadlineView(headline: "categories", action: {})
                        
                        GenreButtonsScrollView(genre: viewModel.movieModels.first!.genre)
                        
                        HeadlineView(headline: "most_popular", action: {})
                        
                        // MARK: Movie poster carousel
                        MoviePosterCarouselView(movieModel: viewModel.movieModels.first!)
                            .padding(.top)
                    }
                }
                .padding(.bottom, 72)
            }
            .background(Color.primaryColor(.mainDark))
            .toolbar {
                // Open WishListView
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        WishListView()
                    } label: {
                        AddToFavoritesLabel()
                    }

                }
                
                // User label
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(.topGunVert)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        
                        Text("Hello, ")
                            .font(.custom(.montSemiBold, size: 16))
                            .foregroundStyle(Color.textColor(.whiteGrey))
                    }
                }                                
            }
        }
    }
}

#Preview {
    HomeView()
}
