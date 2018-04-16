//
//  DVD.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 13/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

public protocol DVD: Explicit
{
    /// Rental price for this collection
    var trackRentalPrice: Double? { get }
    /// Genre name
    var primaryGenreName: String { get }
    /// Advisory rating if needed
    var contentAdvisoryRating: String { get }
    /// Price for regular version
    var collectionPrice: Double? { get }
    /// Price for the HD version
    var collectionHdPrice: Double? { get }
}
