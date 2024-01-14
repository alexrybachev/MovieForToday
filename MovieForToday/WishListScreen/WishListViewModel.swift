//
//  WishListViewModel.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 14.01.2024.
//

import SwiftUI
import Networking

@MainActor
final class WishListViewModel: ObservableObject {
    
    private let networking = NetworkManager(apiKey: globalKey)
    
    @Published var movieModels: [MovieModel] = []
    
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
                movieModels.append(movieData)
            } catch let error {
                print("error fetchMovieInfo for id: ", error.localizedDescription)
            }
        }
    }
    
    func getFavoriteMovies() {
        movieModels = []
        let favoriteMovieIds = StorageManager.shared.getMovies(with: .favoriteKey)
        favoriteMovieIds.forEach { fetchMovieInfo(for: $0) }
    }
}
