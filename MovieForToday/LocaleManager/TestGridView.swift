//
//  TestGridView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 11.01.2024.
//

import SwiftUI

struct TestGridView: View {
    @State private var scrollToIndex: Int?
    @State private var scrollPosition: CGPoint = .zero
    @State private var scaleView: CGFloat?
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(120))], alignment: .center, spacing: 8) {
                    ForEach(0..<15) { index in
                        ItemView(index: index)
                            .id(index)
                    }
                }
                .background(GeometryReader(content: { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                }))
                .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: { value in
                    self.scrollPosition = value
                    self.scrollToIndex = lround(Double(abs(scrollPosition.x) / 220))
                })
            }
            .coordinateSpace(name: "scroll")
            .frame(height: 120)
            
            HStack {
                ForEach(0..<15) { index in
                    if index == scrollToIndex {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 32, height: 10)
                            .foregroundStyle(Color.customMint)
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(Color.customMint.opacity(0.4))
                    }
                }
            }
            
            
            Spacer()
        }
    }
    
}

#Preview {
    TestGridView()
}

struct ItemView: View {
    let index: Int
    
    var body: some View {
        ZStack {
            Color.yellow
                .frame(width: 220)
            Text("index: \(index)")
        }
        .clipShape(.rect(cornerRadius: 20))
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
