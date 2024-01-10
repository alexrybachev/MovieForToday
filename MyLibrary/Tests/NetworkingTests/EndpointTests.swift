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
    
    func test_movieListPaginated() {
        let sut = Endpoint.movieList(page: 2, limit: 1)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/list?page=2&limit=1&notNullFields=cover.url&notNullFields=cover.previewUrl")
        )
    }
    
    func test_movieListWithSlug() {
        let sut = Endpoint.movieList(for: "Baz", page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/list/Baz?page=1&limit=10&notNullFields=cover.url&notNullFields=cover.previewUrl")
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
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&notNullFields=id&notNullFields=name&notNullFields=poster.url&notNullFields=genres.name&notNullFields=top10")
        )
    }
    
    func test_top250Movies() {
        let sut = Endpoint.top250(page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&notNullFields=top250&notNullFields=id&notNullFields=name&notNullFields=poster.url&notNullFields=genres.name")
        )
    }
    
    func test_searchMovieByName() {
        let sut = Endpoint.searchMovie(byName: "Baz", page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=10&query=Baz&notNullFields=id&notNullFields=name&notNullFields=poster.url&notNullFields=genres.name")
        )
    }
    
    func test_searchMovieByKirilicName() {
        let sut = Endpoint.searchMovie(byName: "Баз", page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=10&query=Баз&notNullFields=id&notNullFields=name&notNullFields=poster.url&notNullFields=genres.name")
        )
    }
    
    func test_topRatedMovies() {
        let sut = Endpoint.topRatedMovies(page: 1, limit: 10)
        
        XCTAssertEqual(
            sut.url,
            URL(string: "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&sortField=rating.kp&sortType=1&notNullFields=id&notNullFields=name&notNullFields=poster.url&notNullFields=genres.name")
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
    // Отдельный эндпоинт для просмотра фильма
    // Подсказка - из https://www.kinopoisk.ru/film/ID фильма/ должно получиться https://www.kinopoisk.vip/film/ID фильма/
}
