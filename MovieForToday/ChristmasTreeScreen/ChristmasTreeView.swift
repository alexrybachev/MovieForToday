//
//  ChristmasTreeView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct ChristmasTreeView: View {
    @State private var showingAlert = false
    @State private var currentMovieTitle = ""
    @State private var shuffledMovies: [NYMovie] = []
    
    init() {
        let advice: NewYearMovies = Bundle.main.decode("advice.json")
        _shuffledMovies = State(initialValue: advice.movies.shuffled())
    }
    
    var body: some View {
        ZStack {
            Color.customMain.ignoresSafeArea()
            
            Button {
                showRandomMovie()
            } label: {
                Image(.christmasTree)
                    .resizable()
                    .scaledToFit()
                    .blur(radius: showingAlert ? 10 : 0)
            }
            .padding()
            .alert(currentMovieTitle, isPresented: $showingAlert, actions: {})
        }
    }
    
    private func showRandomMovie() {
        if shuffledMovies.isEmpty {
            let advice: NewYearMovies = Bundle.main.decode("advice.json")
            shuffledMovies = advice.movies.shuffled()
        }
        
        currentMovieTitle = shuffledMovies.removeFirst().title
        showingAlert = true
    }
}

#Preview {
    ChristmasTreeView()
}
