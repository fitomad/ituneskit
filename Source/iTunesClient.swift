//
//  ReceiptValidator.swift
//  ReceiptKit
//
//  Created by Adolfo Vera Blasco on 9/1/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

///
/// All API request will be *returned* here
///
private typealias HttpRequestCompletionHandler = (_ result: HttpResult) -> (Void)

///
/// iTunes result handler.
///
public typealias iTunesCompletionHandler<T> = (_ result: T) -> (Void)


public class iTunesClient
{
    /// Singleton
    public static let shared: iTunesClient = iTunesClient()

    /// Country code. Needed in request's
    /// URL composition
    private let countryCode: String?

    /// JSON decoder for **iTunes Store** responses
    private let decoder: JSONDecoder
    
    /// HTTP session ...
    private var httpSession: URLSession!
    /// ...and his configuración
    private var httpConfiguration: URLSessionConfiguration!

    private let baseURI: String = "https://itunes.apple.com/search"

    /**
        Create HTTP session, JSON decoder...
    */
    private init()
    {
        self.countryCode = Locale.current.regionCode

        self.decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        self.httpConfiguration = URLSessionConfiguration.default
        self.httpConfiguration.httpMaximumConnectionsPerHost = 10
        
        let http_queue: OperationQueue = OperationQueue()
        http_queue.maxConcurrentOperationCount = 10
        
        self.httpSession = URLSession(configuration:self.httpConfiguration,
                                      delegate:nil,
                                      delegateQueue:http_queue)
    }

    /**
        Book search.
     
         - Parameters:
             - name: Book title you're looking for
             - handler: Closure where you willl find your search results
    */
    public func book(named name: String, completionHandler handler: @escaping iTunesCompletionHandler<iTunesResult<Book>>) -> Void
    {
        var songRequest: StoreRequest = StoreRequest(search: name)
        
        songRequest.media = .ebook
        songRequest.entity = .ebook
        songRequest.resultLimit = 30
        
        self.storeRequest(songRequest, handler: handler)
    }

    /**
        Movie search.
     
         - Parameters:
            - name: Movie title you're looking for
            - handler: Closure where you willl find your search results
    */
    public func movie(named name: String, completionHandler handler: @escaping iTunesCompletionHandler<iTunesResult<Movie>>) -> Void
    {
        var songRequest: StoreRequest = StoreRequest(search: name)
        
        songRequest.media = .movie
        songRequest.entity = .movie
        songRequest.attribute = .movieTerm
        songRequest.resultLimit = 30
        
        self.storeRequest(songRequest, handler: handler)
    }

    /**
         Song search.
     
         - Parameters:
             - name: Song title you're looking for
             - handler: Closure where you willl find your search results
    */
    public func song(named name: String, completionHandler handler: @escaping iTunesCompletionHandler<iTunesResult<Song>>) -> Void
    {
        var songRequest: StoreRequest = StoreRequest(search: name, limit: 30)
        
        songRequest.media = .music
        songRequest.entity = .song
        songRequest.attribute = .songTerm
        
        self.storeRequest(songRequest, handler: handler)
    }

    /**
        Search for an item inside the *books*,
        *movies* and *songs* categories.

        - Parameters:
            - name: The item which we are looking for
            - completionHandler: Results will be find there
    */
    public func search(forItemNamed name: String, completionHandler handler: @escaping iTunesCompletionHandler<iTunesResult<Track>>) -> Void
    {
        // iTunes Store results
        var items: [Track] = [Track]()

        // Operations group (GCD)
        let dispath_group: DispatchGroup = DispatchGroup()
        
        dispath_group.enter()
        self.book(named: name, completionHandler: { (result: iTunesResult<Book>) -> (Void) in 
            if case let .success(books) = result
            {
                items.append(contentsOf: books)
            }

            dispath_group.leave()
        })

        dispath_group.enter()
        self.song(named: name, completionHandler: { (result: iTunesResult<Song>) -> (Void) in 
            if case let .success(songs) = result
            {
                items.append(contentsOf: songs)
            }

            dispath_group.leave()
        })

        dispath_group.enter()
        self.movie(named: name, completionHandler: { (result: iTunesResult<Movie>) -> (Void) in 
            if case let .success(movies) = result
            {
                items.append(contentsOf: movies)
            }

            dispath_group.leave()
        })

        // Wait until all search finish
        dispath_group.wait()

        // Return the search results
        if items.isEmpty
        {
            handler(iTunesResult.empty)
        }
        else
        {
            handler(iTunesResult.success(items: items))
        }
    }

    //
    // MARK: - iTunes Store Request
    //
    
    /**
        This is the place where all the requests happends.
     
        There some `StoreRequest`parameters combinations that
        return no results. That's not an error. It's simply that
        the combination it's not available at the **iTunes Store**
     
        - Parameters:
            - request: Search parameters combination
            - handler: Results will be put at this place.
        - SeeAlso: song(named:completionHandler:), movie(named:completionHandler:) and book(named:completionHandler:)
    */
    private func storeRequest<T: Codable>(_ request: StoreRequest, handler: @escaping iTunesCompletionHandler<iTunesResult<T>>) -> Void
    {
        guard let countryCode = self.countryCode else
        {
            handler(iTunesResult.error(message: "Where are you from?"))
            
            return
        }
        
        // Build the different request query items
        
        var url_components: URLComponents = URLComponents(string: self.baseURI)!
     
        var items: [URLQueryItem] = [URLQueryItem]()
        
        // Search term...
        let item_term: URLQueryItem = URLQueryItem(name: "term", value: request.searchTerm)
        items.append(item_term)
        // ...country...
        let item_country: URLQueryItem = URLQueryItem(name: "country", value: countryCode)
        items.append(item_country)
        // ...media if available...
        if let media = request.media
        {
            let item_media: URLQueryItem = URLQueryItem(name: "media", value: media.rawValue)
            items.append(item_media)
        }
        // ...entity if available...
        if let entity = request.entity
        {
            let item_entity: URLQueryItem = URLQueryItem(name: "entity", value: entity.rawValue)
            items.append(item_entity)
        }
        // ...attribute if available...
        if let attribute = request.attribute
        {
            let item_attribute: URLQueryItem = URLQueryItem(name: "attribute", value: attribute.rawValue)
            items.append(item_attribute)
        }
        // ...limit if available...
        if let resultLimit = request.resultLimit
        {
            let item_limit: URLQueryItem = URLQueryItem(name: "limit", value: "\(resultLimit)")
            items.append(item_limit)
        }
        
        url_components.queryItems = items
    
        // Create the request URL
        guard let url = url_components.url else
        {
            handler(iTunesResult.error(message: "Malformed URL."))
            
            return
        }

        // And send the request
        self.processHttp(url, httpHandler: { (result: HttpResult) -> Void in
            switch result
            {
            case .success(let data):
                if let response = try? self.decoder.decode(StoreResponse<T>.self, from: data)
                {
                    if let results = response.results, !response.isEmpty
                    {
                        handler(iTunesResult.success(items: results))
                    }
                    else
                    {
                        handler(iTunesResult.empty)
                    }
                }
            case .requestError(let code, let message):
                let error_message: String = "\(message). Error with code \(code)"
                handler(iTunesResult.error(message: error_message))
            case .connectionError(let reason):
                handler(iTunesResult.error(message: reason))
            }
        })
    }

    //
    // MARK: - HTTP Methods
    //

    /**
        URL request operation

        - Parameters:
            - request: `URLRequest` requested
            - completionHandler: HTTP operation result
    */
    private func processHttp(_ url: URL, httpHandler: @escaping HttpRequestCompletionHandler) -> Void
    {
        let request: URLRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

        let data_task: URLSessionDataTask = self.httpSession.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let error = error
            {
                httpHandler(HttpResult.connectionError(reason: error.localizedDescription))
                return
            }

            guard let data = data, let http_response = response as? HTTPURLResponse else
            {
                httpHandler(HttpResult.connectionError(reason: "No data. No response"))
                return
            }

            switch http_response.statusCode
            {
                case 200:
                    httpHandler(HttpResult.success(data: data))
                    
                default:
                    let code: Int = http_response.statusCode
                    let message: String = HTTPURLResponse.localizedString(forStatusCode: code)

                    httpHandler(HttpResult.requestError(code: code, message: message))
            }
        })

        data_task.resume()
    }
}
