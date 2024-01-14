//
//  HomeViewModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 12.01.2024.
//

import SwiftUI
import Networking

@MainActor
final class HomeViewModel: ObservableObject {
    
    private let networking = NetworkManager(apiKey: globalKey)
    
    @Published var movieCollection: [Collection] = []
    @Published var categories: [String] = ["All"]
    @Published var movieModels: [MovieModel] = []
    @Published var slugModels: [MovieModel] = []
    
    @Published var selectedCategory = 0
    
    func fetchMovieCollection() {
        Task {
            do {
                movieCollection = try await networking.getMovieList().docs
            }
        }
    }
    
    func fetchCategories() {
        Task {
            do {
                let data = try await networking.getAllGenres()
                categories.append(contentsOf: data.map { $0.name } ) }
        }
    }
    
    func fetchMovies(_ category: String) {
        Task {
            do {
                if category == "All" {
                    let docs = try await networking.getTop10Movies().docs
                    movieModels = docs.map {
                        MovieModel(
                            id: $0.id,
                            urlPoster: $0.poster.previewUrl ?? "no urlPoster",
                            backdrop: $0.backdrop?.url ?? "no backdrop",
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
                } else {
                    let docs = try await networking.getMoviesFor(genre: category).docs
                    movieModels = docs.map {
                        MovieModel(
                            id: $0.id,
                            urlPoster: $0.poster.previewUrl ?? "no urlPoster",
                            backdrop: $0.backdrop?.url ?? "no backdrop",
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
    }
    
    func fetchMovies(with slug: String?) {
        print(#function, " with slug ", slug)
        guard let slug = slug else { return }
        print(#function, " with slug ", slug)
        Task {
            do {
                let docs = try await networking.getMoviesFor(slug: slug).docs
                print("slug docs: ", docs)
                slugModels = docs.map {
                    MovieModel(
                        id: $0.id,
                        urlPoster: $0.poster.previewUrl ?? "no urlPoster",
                        backdrop: $0.backdrop?.url ?? "no backdrop",
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
                print("slugModels: ", slugModels)
            } catch let error {
                    print("Error fetchMovies(with slug: String): ", error.localizedDescription)
            }
        }
    }
    
}

