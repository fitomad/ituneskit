//
//  StoreResponse.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 13/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

internal struct StoreResponse<T: Codable>: Codable
{
    /// Items count returned
    internal var resultCount: Int
    /// Store items
    internal var results: [T]?

    /// Check if the request operation returns
    /// any result.
    internal var isEmpty: Bool
    {
        return self.resultCount == 0
    }
}
