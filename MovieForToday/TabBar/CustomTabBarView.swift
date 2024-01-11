//
//  CustomTabBarView.swift
//  MovieForToday
//
//  Created by Alex on 26.12.2023.
//

import SwiftUI

enum Tab: CaseIterable {
    case home, search, download, profile
    
    var title: String {
        switch self {
        case .home: "Home"
        case .search: "Search"
        case .download: "Wishlist"
        case .profile: "Profile"
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .home: .home
        case .search: .search
        case .download: .download
        case .profile: .profile
        }
    }
}

struct CustomTabBarView: View {
    @Binding var selectedTab: Tab
    private let tabBarHeight: CGFloat = 72
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                
                Button {
                    withAnimation {
                        selectedTab = tab
                    }
                } label: {
                    ImageText(
                        image: tab.icon,
                        text: selectedTab == tab ? tab.title : "",
                        color: selectedTab == tab ? .customMint : .textGrey
                    )
                        .padding()
                        .if(selectedTab == tab) { $0.background(.customSoftDark) }
                        .clipShape(Capsule())
                }
                
                Spacer()
            }
        }
        .frame(maxHeight: tabBarHeight)
        .background(.customMain)
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.home))
}
