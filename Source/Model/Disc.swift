//
//  Disc.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 13/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

public protocol Disc: Explicit
{
    /// Collection identifier at the iTunes Store
    var collectionId: Int { get }
    /// Collection name without any restrictions
    var collectionName: String { get }
    /// Collection name censored if needed
    var collectionCensoredName: String { get }
    /// The collection price
    var collectionPrice: Double { get }
    /// Discs number that conforms the collection
    var discCount: Int { get }
    /// Disc position in the collection
    var discNumber: Int { get }
    /// Total tracks availables at the disc
    var trackCount: Int { get }
    /// Track number at the disc
    var trackNumber: Int { get }
}
