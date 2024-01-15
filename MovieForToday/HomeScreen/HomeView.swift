//
//  HomeView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import Networking

struct HomeView<V: View>: View {
    let movieCollection: [Networking.Collection]
    let movieForSelectedGenre: [MovieModel]
    let genres: [String]
    let selectedGenre: String
    let onAppear: () -> Void
    let didSelectGenre: (String) -> Void
    let collectionDestination: (String) -> V
    let categoryDestination: () -> V
    let mostPopularDestination: () -> V
    
    @State private var searchText = ""
    @State private var isSearch = false
    @State private var isShowCategories = false
    @State private var isShowPopular = false
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationView {
            VStack {
                CustomSearchBar(
                    searchText: $searchText,
                    isSearch: $isSearch,
                    placeholderText: "search_a_title..",
                    action: { _ in
                        print("CustomSearchBar on HomeView")
                    }
                )
                .padding(EdgeInsets(top: 26, leading: 16, bottom: 26, trailing: 16))
                
                ScrollView {
                    MovieCategoryPosterCarouselView(
                        movieCollection,
                        destination: collectionDestination
                    )
                    .frame(height: 200)
                    
                    HeadlineView(headline: "categories") {
                        isShowCategories.toggle()
                    }
                    
                    NavigationLink(
                        destination: categoryDestination(),
                        isActive: $isShowCategories,
                        label: {
                            GenreButtonsScrollView(
                                genres: genres,
                                selectedGenre: selectedGenre,
                                action: didSelectGenre
                            )
                            .padding([.leading, .trailing])
                        })
                    
                    HeadlineView(headline: "most_popular") {
                        isShowPopular.toggle()
                    }
                    
                    NavigationLink(
                        destination: mostPopularDestination(),
                        isActive: $isShowPopular,
                        label: {
                            MoviePosterCarouselView(movieModels: movieForSelectedGenre)
                                .padding(.top)
                        })
                }
            }
            .onAppear(perform: onAppear)
            .background(.customMain)
            .toolbar(content: FavoriteToolbarItem.init)
            .toolbar(content: GreetingToolbarItem.init)
        }
    }
}

struct GreetingToolbarItem: ToolbarContent {
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    var body: some ToolbarContent {
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

struct FavoriteToolbarItem: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                WishListView()
            } label: {
                AddToFavoritesLabel()
            }
        }
    }
}

struct HomeViewConnector: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HomeView(
            movieCollection: viewModel.movieCollection, 
            movieForSelectedGenre: viewModel.movieModels,
            genres: viewModel.genres,
            selectedGenre: viewModel.selecteGenre,
            onAppear: viewModel.fetchContent, 
            didSelectGenre: viewModel.didSelect(genre:),
            collectionDestination: { _ in EmptyView() },
            categoryDestination: EmptyView.init,
            mostPopularDestination: EmptyView.init
        )
    }
}

#Preview {
    HomeView(
        movieCollection: Collection.sample, 
        movieForSelectedGenre: [MovieModel.getMocData()],
        genres: ["All", "genre1", "genre2", "genre3"],
        selectedGenre: "All",
        onAppear: {}, 
        didSelectGenre: { _ in },
        collectionDestination: { _ in EmptyView() },
        categoryDestination: EmptyView.init,
        mostPopularDestination: EmptyView.init
    )
    .preferredColorScheme(.dark)
}
