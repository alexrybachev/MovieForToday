//
//  MovieDetailView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss

    @State private var movieTitle = "Spider-Man"
    var body: some View {
        NavigationView {
            ZStack {
                Color(.customMain)
                    .ignoresSafeArea()
                VStack{
                    MovieDetailNavBar(title: movieTitle, buttonAction: likeAction, dismiss: self._dismiss)
                }
            }
        }
    }
    
    //MARK: - methods
    
    func likeAction() {
        //
    }
}

#Preview {
    MovieDetailView()
}
