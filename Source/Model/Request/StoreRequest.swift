//
//  StoreRequest.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 9/1/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

public struct StoreRequest
{
    /// Number of items availables at the results
    public var resultLimit: Int?
    /// What you are looking for
    public private(set) var searchTerm: String
    /// Search media type
    public var media: Media?
    /// What **kind** of thing are you looking for
    public var entity: Entity?
    /// Attributes where you perform your search
    public var attribute: Attribute?
    /// Country code to match a iTunes Country Store
    internal var countryCode: String!

    /**
        New request with a custom limit
     
         - Parameters
            - search: What are you looking for
            - limit: How many results will be available at the result
    */
    public init(search term: String, limit: Int)
    {
        self.searchTerm = term
        self.resultLimit = limit
    }

    /**
        New request with a predefined 25 results limit.
     
        - Parameter search: What are you looking for
    */
    public init(search term: String)
    {
        self.init(search: term, limit: 25)
    }
}


