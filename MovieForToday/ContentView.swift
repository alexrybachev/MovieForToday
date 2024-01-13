//
//  ContentView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    private let tabBarHeight: CGFloat = 72
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                switch selectedTab {
                case .home:
                    HomeView()
                case .search:
                    SearchView()
                case .tree:
                    ChristmasTreeView()
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
    ContentView()
        .environment(\.locale, .init(identifier: "en"))
}

#Preview("Russian") {
    ContentView()
        .environment(\.locale, .init(identifier: "ru"))
}
