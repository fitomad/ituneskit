//
//  Song.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 9/1/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

// Song result
typealias SongTrack = Track & Artwork & Previewing & Disc & Timing

public struct Song: SongTrack, Codable
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

    /// MARK: - Previewing Protocol

    public var previewURL: URL?

    /// MARK: - Disc Protocol

    public var collectionId: Int
    public var collectionName: String
    public var collectionCensoredName: String
    public var collectionPrice: Double
    public var discCount: Int
    public var discNumber: Int
    public var trackCount: Int 
    public var trackNumber: Int
    public var collectionExplicitness: Explicitness
    public var trackExplicitness: Explicitness
    
    /// MARK: - Timing Protocol
    
    public internal(set) var trackTimeMillis: Int
}

//
// MARK: - Equatable Protocol
//

extension Song: Equatable
{
    public static func ==(lhs: Song, rhs: Song) -> Bool
    {
        return (lhs.trackName == rhs.trackName) && (lhs.collectionName == rhs.collectionName)
    }

    public static func !=(lhs: Song, rhs: Song) -> Bool
    {
        return !(lhs == rhs)
    }
}

//
// MARK: - CustomStringConvertible Protocol
//

extension Song: CustomStringConvertible
{
    ///
    public var description: String
    {
        return "\(self.trackName) － \(self.collectionName) @ \(self.artistName)"
    }
}
