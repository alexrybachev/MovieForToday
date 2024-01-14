//
//  HomeView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var searchText = ""
    @State private var isSearch = false
    
    @State private var isShowCategories = false
    @State private var isShowPopular = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    CustomSearchBar(
                        searchText: $searchText,
                        isSearch: $isSearch,
                        placeholderText: "search_a_title..",
                        action: { _ in
                            print("CustomSearchBar on HomeView")
                        }
                    )
                    .padding(EdgeInsets(top: 26, leading: 16, bottom: 26, trailing: 16))
                    
                    MovieCategoryPosterCarouselView(homeViewModel: homeViewModel)
                        .frame(height: 200)
                    
                    NavigationLink(
                        destination: PopularMovieView(viewModel: homeViewModel, slug: nil),
                        isActive: $isShowCategories,
                        label: {
                            HeadlineView(headline: "categories", action: {
                                isShowCategories.toggle()
                            })
                        })
                    
                    GenreButtonsScrollView(
                        selectedCategory: $homeViewModel.selectedCategory,
                        categories: $homeViewModel.categories,
                        action: { category in
                            homeViewModel.fetchMovies(category)
                        }
                    )
                    .padding([.leading, .trailing])
                    
                    HeadlineView(headline: "most_popular", action: {
                        print("tap 'see all' on most_popular")
                    })
                    
                    MoviePosterCarouselView(movieModels: $homeViewModel.movieModels)
                        .padding(.top)
                }
            }
            .task {
//                let category = homeViewModel.categories[homeViewModel.selectedCategory]
//                homeViewModel.fetchMovies(category)
            }
            .background(.customMain)
            .toolbar {
                // Open WishListView
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        WishListView()
                    } label: {
                        AddToFavoritesLabel()
                    }
                }
                
                // TODO: User label
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(.topGunVert)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        
                        Text("Hello, ")
                            .font(.custom(.montSemiBold, size: 16))
                            .foregroundStyle(.textWhiteGrey)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(homeViewModel: HomeViewModel())
}
