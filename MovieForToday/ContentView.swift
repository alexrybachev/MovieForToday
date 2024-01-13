//
//  ContentView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var selectedTab: Tab = .home
    private let tabBarHeight: CGFloat = 72
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                switch selectedTab {
                case .home:
                    HomeView(homeViewModel: homeViewModel)
                case .search:
                    SearchView()
                case .download:
                    WishListView()
                case .profile:
                    ProfileView()
                }
            }
            .padding(.bottom, tabBarHeight)
            
            CustomTabBarView(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview("English") {
    ContentView(homeViewModel: HomeViewModel())
        .environment(\.locale, .init(identifier: "en"))
}

#Preview("Russian") {
    ContentView(homeViewModel: HomeViewModel())
        .environment(\.locale, .init(identifier: "ru"))
}
