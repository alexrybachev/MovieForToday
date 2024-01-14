//
//  EndpointTests.swift
//  
//
//  Created by Илья Шаповалов on 24.12.2023.
//

import XCTest
@testable import Networking

final class EndpointTests: XCTestCase {
    func test_movieList() {
        let sut = Endpoint.movieList(page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/list?page=1&limit=10&notNullFields=cover.url&notNullFields=cover.previewUrl")
        )
    }
    
    func test_moviesWithSlug() {
        let sut = Endpoint.moviesFor(genre: "Baz", page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&notNullFields=id&notNullFields=name&notNullFields=rating.kp&notNullFields=poster.url&notNullFields=genres.name&genres.name=Baz")
        )
    }
    
    func test_searchMovieById() {
        let sut = Endpoint.movie(withId: 1)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie/1")
        )
    }
    
    func test_genresList() {
        let sut = Endpoint.genres
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1/movie/possible-values-by-field?field=genres.name")
        )
    }
    
    func test_top10Movies() {
        let sut = Endpoint.top10(page: 1, limit: 10)
        
        XCTAssertEqual(sut.url.pathComponents.contains("/"), true)
        XCTAssertEqual(sut.url.pathComponents.contains("v1.4"), true)
        XCTAssertEqual(sut.url.pathComponents.contains("movie"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("limit=10"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=id"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=name"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=rating.kp"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=poster.url"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=genres.name"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=top10"), true)
    }
    
    func test_top250Movies() {
        let sut = Endpoint.top250(page: 1, limit: 10)
        
        XCTAssertEqual(sut.url.pathComponents.contains("/"), true)
        XCTAssertEqual(sut.url.pathComponents.contains("v1.4"), true)
        XCTAssertEqual(sut.url.pathComponents.contains("movie"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("limit=10"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=id"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=name"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=rating.kp"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=poster.url"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=genres.name"), true)
        XCTAssertEqual(sut.url.absoluteString.contains("notNullFields=top250"), true)
    }
    
    func test_searchMovieByName() {
        let sut = Endpoint.searchMovie(byName: "Baz", page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=10&query=Baz&notNullFields=id&notNullFields=name&notNullFields=rating.kp&notNullFields=poster.url&notNullFields=genres.name")
        )
    }
    
    func test_searchMovieByKirilicName() {
        let sut = Endpoint.searchMovie(byName: "Баз", page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=10&query=Баз&notNullFields=id&notNullFields=name&notNullFields=rating.kp&notNullFields=poster.url&notNullFields=genres.name")
        )
    }
    
    func test_topRatedMovies() {
        let sut = Endpoint.topRatedMovies(page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&sortField=rating.kp&sortType=1&notNullFields=id&notNullFields=name&notNullFields=rating.kp&notNullFields=poster.url&notNullFields=genres.name")
        )
    }
    
    func test_personByID() {
        let sut = Endpoint.person(withId: 1)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/person/1")
        )
    }
    
    func test_searchPersonByName() {
        let sut = Endpoint.searchPerson(byName: "Baz", page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/person/search?page=1&limit=10&query=Baz")
        )
    }
    
    func test_searchPersonByKirilicName() {
        let sut = Endpoint.searchPerson(byName: "Баз", page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/person/search?page=1&limit=10&query=Баз")
        )
    }
    
    func test_getMoviesForSlug() {
        let sut = Endpoint.moviesFor(slug: "Baz", page: 1, limit: 10)
        
        XCTAssertEqual(sut.url, URL(string: "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&lists=Baz"))
    }
}
