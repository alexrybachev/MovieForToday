//
//  PagingIndexView.swift
//  MovieForToday
//
//  Created by Alex on 10.01.2024.
//

import SwiftUI

struct PagingIndexView: View {
    let numberOfItems: Int
    let selectedTab: Int
    
    private let dotHeight: CGFloat = 8
    private let dotWidth: CGFloat = 24
    private let dotSpacing: CGFloat = 8
    private let primaryColor = Color.customMint
    private let secondaryColor = Color.customMint.opacity(0.5)
    
    var body: some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<numberOfItems) { index in
                if showIndex(index) {
                    Capsule()
                        .foregroundStyle(selectedTab == index ? primaryColor : secondaryColor)
                        .scaleEffect(selectedTab == index ? 1 : 0.8)
                        .frame(
                            width: selectedTab == index ? dotWidth : dotHeight,
                            height: dotHeight
                        )
                }
            }
        }
    }
    
    private func showIndex(_ index: Int) -> Bool {
        ((selectedTab - 1)...(selectedTab + 1)).contains(index)
    }
}

#Preview {
    PagingIndexView(numberOfItems: 5, selectedTab: 0)
}
