//
//  iTunesKitTests.swift
//  iTunesKitTests
//
//  Created by Adolfo Vera Blasco on 10/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import XCTest
@testable import iTunesKit

class iTunesKitTests: XCTestCase {
    
    private let bookTitles: [String] = [
        "Ready Player One",
        "El nombre de la rosa",
        "Salem's Lot",
        "El ciclo del hombre lobo",
        "Hyperion",
        "Sin noticias de Gurb",
        "El oro del rey",
        "El problema de los tres cuerpos",
        "Microsiervos",
        "JPod",
        "La Torre Oscura",
        "Bellas durmientes",
        "90 segundos",
        "Los hombres que no amaban a las mujeres",
        "El juego de Ender"
    ]
    
    private var songTitles: [String] = [
        "Enjoy the silence",
        "Policy of truth",
        "In your room",
        "Temple",
        "Paradise city",
        "Behind close doors",
        "Kids in love",
        "Pizza",
        "meteora",
        "bedbugs",
        "Where them girls at",
        "waiting for the night",
        "the trooper",
        "Crazy Nights",
        "Fuel",
        "A tout le monde",
        "take on me",
        "the sun always shines on tv",
        "shoot to thrill",
        "you learn",
        "places to go",
        "Mi primer día",
        "airplanes",
        "colors",
        "heaven is a place on earth",
        "Adam's song",
        "Song 2",
        "i'm goin' down",
        "no me canso",
        "something just like this",
        "ridiculous thoughts",
        "rich  love",
        "state of love and trust",
        "bohemian rapsody",
        "fortune fadder",
        "i don't wanna be here anymore",
        "on n'est pas comme ça",
        "de música ligera",
        "save the world",
        "in da club",
        "million miles away",
        "if today was your last day",
        "lift me up"
    ]
    
    private let movieTitles: [String] = [
        "Margin Call",
        "Indiana Jones",
        "Star Wars",
        "Los Goonies",
        "The Last Startfighter",
        "Los Gremlins",
        "Cazafantasmas",
        "Noche de miedo",
        "Trabajo basura",
        "Office space",
        "Jobs",
        "Terrorífica luna de miel",
        "Bullit",
        "Los pájaros",
        "El caso Bourne",
        "Critters",
        "Apollo XIII",
        "El lobo de Wall Street",
        "Black Panther",
        "Ant-Man",
        "Spiderman Homecoming",
        "Iron Man",
        "Thor: El Mundo Oscuro",
        "Capitan América: Civil War",
        "La Princesa Prometida",
        "Los Inmortales",
        "American Gangster",
        "Plan Oculto",
        "El secreto de la pirámide"
    ]
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //
    // MARK: - Book Tests
    //
    
    func testBookSearch()
    {
        let expectation: XCTestExpectation = self.expectation(description: "Book search")
        
        iTunesClient.shared.book(named: "Ready Player One") { (result: iTunesResult<Book>) -> (Void) in
            switch result
            {
                case .success(let books):
                    print("Se han encontrado \(books.count) libros.")
                    
                    for book in books
                    {
                        print("# \(book) Size: \(book.formattedFileSize)")
                    }
                
                case .error(let message):
                    print(message)
                
                case .empty:
                    print("No se ha encontrado nada de nada...")
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testBulkBookSearch() -> Void
    {
        for bookTitle in self.bookTitles
        {
            let expectation: XCTestExpectation = self.expectation(description: "Book Bulk search")
            
            iTunesClient.shared.book(named: bookTitle) { (result: iTunesResult<Book>) -> (Void) in
                switch result
                {
                    case .success(let books):
                        print("# Se han encontrado \(books.count) libros titulados \(bookTitle).")
                    
                    case .error(let message):
                        print("!!! \(message)")
                    
                    case .empty:
                        print("[] No se ha encontrado nada de nada...")
                }
                
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testPerformanceBookSearch()
    {
        // This is an example of a performance test case.
        self.measure
            {
                self.testBookSearch()
        }
    }
    
    func testPerformanceBulkBookSearch()
    {
        // This is an example of a performance test case.
        self.measure
        {
            self.testBulkBookSearch()
        }
    }
    
    //
    // MARK: - Song Tests
    //
    
    func testSongSearch()
    {
        let expectation: XCTestExpectation = self.expectation(description: "Song search")
        
        iTunesClient.shared.song(named: "Enjoy the silence") { (result: iTunesResult<Song>) -> (Void) in
            switch result
            {
                case .success(let songs):
                    print("Se han encontrado \(songs.count) canciones.")
                    
                    for song in songs
                    {
                        print("\(song) duración \(song.fomattedTrackTime)")
                    }
                
                case .error(let message):
                    print(message)
                
                case .empty:
                    print("No se ha encontrado nada de nada...")
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testBulkSongSearch() -> Void
    {
        for songTitle in self.songTitles
        {
            let expectation: XCTestExpectation = self.expectation(description: "Book search")
            
            iTunesClient.shared.song(named: songTitle) { (result: iTunesResult<Song>) -> (Void) in
                switch result
                {
                case .success(let songs):
                    print("# Se han encontrado \(songs.count) canciones tituladas \(songTitle).")
                    
                case .error(let message):
                    print("!!! \(message)")
                    
                case .empty:
                    print("[] No se ha encontrado nada de nada...")
                }
                
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testPerformanceSongSearch()
    {
        // This is an example of a performance test case.
        self.measure
            {
                self.testSongSearch()
        }
    }
    
    func testPerformanceBulkSongSearch()
    {
        // This is an example of a performance test case.
        self.measure
            {
                self.testBulkSongSearch()
        }
    }
    
    //
    // MARK: - Movie Tests
    //
    
    func testMovieSearch()
    {
        let expectation: XCTestExpectation = self.expectation(description: "Movie search")
        
        iTunesClient.shared.movie(named: "Jobs") { (result: iTunesResult<Movie>) -> (Void) in
            switch result
            {
            case .success(let movies):
                print("Se han encontrado \(movies.count) películas.")
                
                for movie in movies
                {
                    print("\(movie) duration \(movie.fomattedTrackTime)")
                }
                
            case .error(let message):
                print(message)
                
            case .empty:
                print("No se ha encontrado nada de nada...")
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testBulkMovieSearch() -> Void
    {
        for movieTitle in self.movieTitles
        {
            let expectation: XCTestExpectation = self.expectation(description: "Movie Bulk search")
            
            iTunesClient.shared.movie(named: movieTitle) { (result: iTunesResult<Movie>) -> (Void) in
                switch result
                {
                case .success(let movies):
                    print("# Se han encontrado \(movies.count) películas tituladas \(movieTitle).")
                    
                case .error(let message):
                    print("!!! \(message) [\(movieTitle)]")
                    
                case .empty:
                    print("[] No se ha encontrado la película \(movieTitle)...")
                }
                
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testPerformanceMovieSearch()
    {
        // This is an example of a performance test case.
        self.measure
            {
                self.testMovieSearch()
        }
    }
    func testPerformanceBulkMovieSearch()
    {
        // This is an example of a performance test case.
        self.measure
            {
                self.testBulkMovieSearch()
        }
    }
    
    //
    // MARK: - General Search
    //
    
    func testGeneralSearch() -> Void
    {
        let expectation: XCTestExpectation = self.expectation(description: "General search")
        
        iTunesClient.shared.search(forItemNamed: "Jobs") { (result: iTunesResult<Track>) -> (Void) in
            switch result
            {
            case .success(let items):
                print("Se han encontrado \(items.count) elementos.")
                
                print("Movies...")
                for case let movie as Movie in items
                {
                    print("\t－ \(movie.trackName) directed by \(movie.artistName). Duration: \(movie.fomattedTrackTime)")
                }
                
                print("Books...")
                for case let book as Book in items
                {
                    print("\t－ \(book.trackName) by \(book.artistName). File Size: \(book.formattedFileSize)")
                }
                
                print("Songs...")
                for case let song as Song in items
                {
                    print("\t－ \(song.trackName) (\(song.collectionName)). Duration: \(song.fomattedTrackTime)")
                }

                
            case .error(let message):
                print(message)
                
            case .empty:
                print("No se ha encontrado nada de nada...")
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testPerformanceGeneralSearch() -> Void
    {
        self.measure {
            self.testGeneralSearch()
        }
    }
}
