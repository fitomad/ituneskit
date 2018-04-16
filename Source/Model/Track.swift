//
//  Track.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 9/1/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

public protocol Track
{
    /// Unique identifier for this items inside iTunes Store
    var trackId: Int { get }
    /// Name
    var trackName: String { get }
    /// iTunes Store website page
    var trackViewUrl: URL { get }
    /// Item name censored if needed
    var trackCensoredName: String { get }
    /// Kind of item (movie, song...)
    var kind: Kind { get }
    /// Item creator
    var artistName: String { get }
    /// Price currency
    var currency: String { get }
    /// Available in iTunes Store since this date
    var releaseDate: Date { get }
    /// Price for this item.
    /// If not price available it means that It's on pre-sale
    var trackPrice: Double? { get }
}

