//
//  PopularMovieViewModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 24.12.2023.
//

import SwiftUI

final class PopularMovieViewModel: ObservableObject {
    
    @Published var movieModels = [MovieModel.getMocData()]
    
}
