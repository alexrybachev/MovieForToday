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
    
    private let networking = NetworkManager(apiKey: globalKey)
    
    @Published var categories: [String] = ["All"]
    @Published var upcomingMovies: [MovieModel] = []
    @Published var recentMovies: [MovieModel] = []
    @Published var movieModels: [MovieModel] = []
    @Published var persons: [MoviePerson] = []

    @Published var selectedCategory = 0
    
    @Published var recentMovieIds: [Int] = []
    
    @Published var searchText = ""
    @Published var isSearch = false
    
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
    
    func fetchMovies(with query: String) {
        movieModels = []
        Task {
            do {
                let docs = try await networking.searchMovie(named: query).docs
                movieModels.append(
                    contentsOf: docs.map {
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
                print(movieModels)
            } catch let error {
                print("Error fetchMovies(with query: String): ", error.localizedDescription)
            }
        }
    }
    
    func fetchPersons(with query: String) {
        persons = []
        Task {
            do {
                let docs = try await networking.searchPerson(named: query).docs
                persons = docs.map {
                    MoviePerson(
                        id: $0.id,
                        photo: $0.photo ?? "",
                        name: $0.name ?? "",
                        profession: $0.profession ?? ""
                    )
                }
            } catch let error {
                print("Error fetchPersons(with query: String): ", error.localizedDescription)
            }
        }
    }
    
    func getRecentMovieIds() {
        recentMovieIds = StorageManager.shared.getMovies(with: .recentKey)
        recentMovieIds.forEach { fetchMovieInfo(for: $0) }
    }
    
    private func fetchMovieInfo(for id: Int) {
        Task {
            do {
                let data = try await networking.getMovie(withId: id)
                let persons = data.persons?.compactMap {
                    MoviePerson(
                        id: $0.id,
                        photo: $0.photo ?? "",
                        name: $0.name ?? "",
                        profession: $0.profession ?? ""
                    )
                }
                let movieData = MovieModel(
                    id: data.id,
                    urlPoster: data.poster.previewUrl ?? "no urlPoster",
                    backdrop: data.backdrop?.url ?? "no backdrop",
                    rating: data.rating.kp.convertToString,
                    name: data.name ?? "no name",
                    description: data.description ?? "no description",
                    year: String(data.year ?? 0),
                    duration: String(data.movieLength ?? 0),
                    genres: data.genres?.compactMap { $0.name } ?? [],
                    persons: persons ?? [],
                    trailerUrl: data.videos?.trailers.first?.url ?? ""
                )
                recentMovies.append(movieData)
            } catch let error {
                print("error fetchMovieInfo for id: ", error.localizedDescription)
            }
        }
    }
    
}
