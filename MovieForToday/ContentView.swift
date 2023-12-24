//
//  ContentView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.custom(.montMedium, size: 16))
                .background(Color.primaryColor(.mint))
            
            Text("language")
        }
        .padding()
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
