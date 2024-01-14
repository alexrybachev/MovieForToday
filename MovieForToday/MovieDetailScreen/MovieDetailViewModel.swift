//
//  MovieDetailViewModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 13.01.2024.
//

import SwiftUI
import Networking

@MainActor
final class MovieDetailViewModel: ObservableObject {
    
    private let networking = NetworkManager(apiKey: "BR9GX9R-2TD4AQX-H67HE11-CSGFVP4")
    
    @Published var movieModel = MovieModel(
        id: 0,
        urlPoster: "",
        backdrop: "",
        rating: "",
        name: "",
        description: "",
        year: "",
        duration: "",
        genres: [],
        persons: [],
        trailerUrl: ""
    )
    
    @Published var movieImages: [MovieImage] = []
    
    func fetchMovieDetail(for id: Int) {
        Task {
            do {
                let data = try await networking.getMovie(withId: id)
                print("\nDATA:\n", data)
                let persons = data.persons?.compactMap {
                    MoviePerson(
                        id: $0.id,
                        photo: $0.photo ?? "",
                        name: $0.name ?? "",
                        profession: $0.profession ?? ""
                    )
                }
                movieModel = MovieModel(
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
            } catch let error {
                print("Error fetchMovieDetail(for id: Int): ", error.localizedDescription)
            }
            
        }
    }
    
    func fetchMovieImages(for id: Int) {
        Task {
            do {
                let docs = try await networking.getImages(for: id).docs
                movieImages = docs.map {
                    MovieImage(
                        id: $0.movieId ?? 0,
                        url: $0.url ?? "",
                        previewUrl: $0.previewUrl ?? ""
                    )
                }
            } catch let error {
                print("Error fetchMoviewImages: ", error.localizedDescription)
            }
        }
    }
    
    func saveRecentMovie(with id: Int) {
        StorageManager.shared.saveRecentMovie(with: id)
    }
    
    func saveFavoriteMovie(with id: Int) {
        print("saveFavoriteMovie for: ", id)
        StorageManager.shared.saveFavoriteMovie(with: id)
    }
}



