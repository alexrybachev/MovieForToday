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
                        // CustomSearchBar
                        CustomSearchBar(
                            searchText: $searchText,
                            isSearch: $isSearch,
                            placeholderText: "search_a_title..", action: {}
                        )
                        .padding(EdgeInsets(top: 26, leading: 16, bottom: 26, trailing: 16))
                        
                        
                        // Image carousel
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<3) { _ in
                                    MovieImageView(image: Image(.topGunVert), width: 295, height: 154, cornerRadius: 16)
                                        .overlay {
                                            VStack(alignment: .leading) {
                                                Text(viewModel.movieModels.first!.name)
                                                    .foregroundStyle(Color.textColor(.whiteGrey))
                                                    .font(.custom(.montSemiBold, size: 16))
                                                    .padding(.bottom)
                                                
                                                Text(viewModel.movieModels.first!.category)
                                                    .foregroundStyle(Color.textColor(.whiteGrey))
                                                    .font(.custom(.montMedium, size: 12))
                                            }
                                            .offset(x: -90, y: 30)
                                        }
                                }
                            }
                        }
                        .padding(.bottom, 30)
                        
                        HeadlineView(headline: "categories", action: {})
                        
                        GenreButtonsScrollView(genre: viewModel.movieModels.first!.genre)
                        
                        HeadlineView(headline: "most_popular", action: {})
                            .padding(.bottom)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<3) { _ in
                                    MovieImageView(image: Image(.topGunVert), width: 135, height: 231, cornerRadius: 16)
                                        .overlay {
                                            RatingView(rating: "4.5", isBackground: true)
                                                .offset(x: 30, y: -90)
                                                                                        
                                            VStack(alignment: .leading) {
                                                Text(viewModel.movieModels.first!.name)
                                                    .foregroundStyle(Color.textColor(.whiteGrey))
                                                    .font(.custom(.montSemiBold, size: 16))
                                                    .padding(.bottom)
                                                
                                                Text(viewModel.movieModels.first!.category)
                                                    .foregroundStyle(Color.textColor(.whiteGrey))
                                                    .font(.custom(.montMedium, size: 12))
                                            }
                                            .frame(width: 135, height: 70)
                                            .background(Color.primaryColor(.softDark))
                                            .offset(y: 70)
                                        }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 72)
            }
            .background(Color.primaryColor(.mainDark))
            .toolbar {
                // TODO: Зачем тут эта кнопка?
                ToolbarItem(placement: .topBarTrailing) {
                    AddToFavoritesButton(action: {})
                }
                
                // User label
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(.topGunVert)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        
                        Text("Hello, Smith")
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
