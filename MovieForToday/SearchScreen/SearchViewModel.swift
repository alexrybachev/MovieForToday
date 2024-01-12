//
//  SearchViewModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 10.01.2024.
//

import SwiftUI
import Networking

final class SearchViewModel: ObservableObject {
    
    private let networking = NetworkManager(apiKey: "91FNPYK-28Z4N08-K3AEZFE-G1204N7")
    
    @Published var categories: [String] = ["All"]
    @Published var movieModels: [MovieModel] = []
    @Published var searchText = ""
    @Published var isSearch = false
    
    @Published var selectedTag = 0
    
    @MainActor
    func fetchCategories() {
        Task {
            do {
                let data = try await networking.getAllGenres()
                categories.append(contentsOf: data.map { $0.slug } )
//                categories = data.map { Genre(ruName: $0.name, enName: $0.slug) }
            }
        }
    }
    
    #warning("Доделать метод")
    @MainActor
    func fetchMovies(with query: String) {
        Task {
            do {
                let data = try await networking.searchMovie(named: query)
                let movies = data.docs
                movieModels.append(
                    contentsOf: movies.map {
                        MovieModel(id: $0.id,
                                   urlPoster: $0.logo?.url ?? "",
                                   rating: $0.rating.kp.convertToString,
                                   name: $0.name ?? "",
                                   year: String($0.year ?? 0),
                                   duration: String($0.movieLength ?? 0),
                                   genres: ["no genre"],
                                   category: "no category")
                    }
                )
            }
        }
    }
}
