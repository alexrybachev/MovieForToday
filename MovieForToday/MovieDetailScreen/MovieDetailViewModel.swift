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
    
    private let networking = NetworkManager(apiKey: "NHF9KRY-Y43MNST-K5GMVR9-40FZPJS") // "91FNPYK-28Z4N08-K3AEZFE-G1204N7"
    
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
    
    func fetchMovieDetail(for id: Int) {
        print("id: ", id)
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
                print("\nfetchMovieDetail movieModel: \n", data)
                print("\nfetchMovieDetail movieModel: \n", movieModel)
            } catch let error {
                print("ERROR fetchMovieDetail(for id: Int): ", error.localizedDescription)
            }
            
        }
    }
    
    func saveMovie(with id: Int) {
        StorageManager.shared.saveMovie(with: id)
    }
}



