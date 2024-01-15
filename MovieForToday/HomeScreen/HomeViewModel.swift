//
//  HomeViewModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 12.01.2024.
//

import SwiftUI
import Networking

final class HomeViewModel: ObservableObject {
    
    private let networking = NetworkManager(apiKey: globalKey)
    
    @Published var movieCollection: [Collection] = []
    @Published var genres: [String] = ["All"]
    @Published var movieModels: [MovieModel] = []
    @Published var slugModels: [MovieModel] = []
    @Published var selecteGenre: String = .init()
    @Published var selectedCategory = 0
    
    func didSelect(genre: String) {
        selecteGenre = genre
        fetchMovies(selecteGenre)
    }
    
    func fetchMovieCollection() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let collections = try await networking.getMovieList().docs
                await MainActor.run {
                    self.movieCollection = collections
                }
            }
        }
    }
    
    func fetchCategories() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let data = try await networking.getAllGenres()
                await MainActor.run {
                    self.genres.append(contentsOf: data.map { $0.name } ) }
                }
        }
    }
    
    func fetchMovies(_ genre: String) {
        Task { [weak self] in
            guard let self else { return }
            do {
                let docs = genre.elementsEqual("All")
                ? try await networking.getTop10Movies().docs
                : try await networking.getMoviesFor(genre: genre).docs
                let movies = docs.map(MovieModel.init)
                await MainActor.run {
                    self.movieModels = movies
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func fetchMovies(with slug: String) {
        Task { [weak self] in
            guard let self else { return }
            do {
                let docs = try await networking.getMoviesFor(slug: slug).docs
                let movies = docs.map(MovieModel.init)
                await MainActor.run {
                    self.slugModels = movies
                }
            } catch let error {
                    print("Error fetchMovies(with slug: String): ", error.localizedDescription)
            }
        }
    }
    
    func fetchContent() {
        let category = genres[selectedCategory]
        fetchMovies(category)
    }
    
    func foo() {
        fetchMovieCollection()
        fetchCategories()
        fetchContent()
    }
    
}

extension MovieModel {
    init(_ movie: Networking.Movie) {
    id = movie.id
    urlPoster = movie.poster.previewUrl ?? "no urlPoster"
    backdrop = movie.backdrop?.url ?? "no backdrop"
    rating = movie.rating.kp.convertToString
    name = movie.name ?? "no name"
    description = movie.description ?? "no description"
    year = String(movie.year ?? 0)
    duration = String(movie.movieLength ?? 0)
    genres = movie.genres?.compactMap { $0.name.capitalized } ?? []
    persons = []
    trailerUrl = movie.videos?.trailers.first?.url ?? ""
    }
}
