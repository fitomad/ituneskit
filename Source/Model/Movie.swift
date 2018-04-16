//
//  Movie.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 9/1/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

// Movie result
typealias MovieTrack = Track & Artwork & Previewing & DVD & Timing

public struct Movie: MovieTrack, Codable
{
    /// MARK: - Artwork Protocol

    public var artworkUrl100: URL
    public var artworkUrl60: URL

    /// MARK: - Track Protocol

    public var trackId: Int
    public var trackName: String
    public var trackViewUrl: URL
    public var trackCensoredName: String
    public var kind: Kind
    public var artistName: String
    public var currency: String
    public var releaseDate: Date
    public var trackPrice: Double?
    
    /// MARK: - DVD Protocol

    public var trackRentalPrice: Double?
    public var primaryGenreName: String
    public var contentAdvisoryRating: String
    public var collectionPrice: Double?
    public var collectionHdPrice: Double?
    public var collectionExplicitness: Explicitness
    public var trackExplicitness: Explicitness
    
    /// MARK: - Previewing Protocol
    
    public var previewURL: URL?
    
    /// MARK: - Timing Protocol
    
    public var trackTimeMillis: Int
}

//
// MARK: - Equatable Protocol
//

extension Movie: Equatable
{
    public static func ==(lhs: Movie, rhs: Movie) -> Bool
    {
        return (lhs.trackName == rhs.trackName) 
    }

    public static func !=(lhs: Movie, rhs: Movie) -> Bool
    {
        return !(lhs == rhs)
    }
}

//
// MARK: - CustomStringConvertible Protocol
//

extension Movie: CustomStringConvertible
{
    public var description: String
    {
        return "\(self.trackName) directed by \(self.artistName)"
    }
}
