//
//  SearchViewModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 10.01.2024.
//

import SwiftUI
import Networking

@MainActor
final class SearchViewModel: ObservableObject {
    
    private let networking = NetworkManager(apiKey: "NHF9KRY-Y43MNST-K5GMVR9-40FZPJS") // "91FNPYK-28Z4N08-K3AEZFE-G1204N7"
    
    @Published var categories: [String] = ["All"]
    @Published var upcomingMovies: [MovieModel] = []
    @Published var movieModels: [MovieModel] = []
    @Published var searchText = ""
    @Published var isSearch = false
    
    @Published var selectedTag = 0
    
    @Published var recentMovieIds: [Int] = []
    
    @MainActor
    func fetchCategories() {
        Task {
            do {
                let data = try await networking.getAllGenres()
                categories.append(contentsOf: data.compactMap { $0.slug } )
            }
        }
    }
    
    func fetchUpcomingMovie() {
        Task {
            do {
                let docs = try await networking.getMoviesReleasedAt(year: 2024).docs
                upcomingMovies = docs.map {
                    MovieModel(
                        id: $0.id,
                        urlPoster: $0.poster.previewUrl ?? "no urlPoster",
                        backdrop: $0.backdrop?.previewUrl ?? "no backdrop",
                        rating: $0.rating.kp.convertToString,
                        name: $0.name ?? "no name",
                        description: $0.description ?? "no description",
                        year: String($0.year ?? 0),
                        duration: String($0.movieLength ?? 0),
                        genres: $0.genres?.compactMap { $0.name.capitalized } ?? [],
                        persons: [],
                        trailerUrl: $0.videos?.trailers.first?.url ?? ""
                    )
                }
            }
        }
    }
    
    func fetchMovies(with query: String) {
        Task {
            do {
                let data = try await networking.searchMovie(named: query)
                let movies = data.docs
                movieModels.append(
                    contentsOf: movies.map {
                        MovieModel(
                            id: $0.id,
                            urlPoster: $0.logo?.url ?? "",
                            backdrop: $0.backdrop?.previewUrl ?? "no backdrop",
                            rating: $0.rating.kp.convertToString,
                            name: $0.name ?? "",
                            description: $0.description ?? "",
                            year: String($0.year ?? 0),
                            duration: String($0.movieLength ?? 0),
                            genres: $0.genres?.compactMap { $0.name.capitalized } ?? [],
                            persons: [],
                            trailerUrl: $0.videos?.trailers.first?.url ?? ""
                        )
                    }
                )
            }
        }
    }
    
    func getRecentMovieIds() {
        recentMovieIds = StorageManager.shared.getMovies(with: .recentKey)
    }
}
