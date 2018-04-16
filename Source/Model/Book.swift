//
//  Book.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 9/1/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

// Book result
typealias BookTrack = Track & Artwork & Sizing

public struct Book: BookTrack, Codable
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
    
    /// MARK: - Sizing Protocol
    
    public var fileSizeBytes: Int
    
    /// Los ebooks tienen la propiedad `trackPrice`
    /// codificada como `price` en el documento JSON.
    /// Es el único caso en la iTunes Store
    private enum CodingKeys: String, CodingKey
    {
        case trackPrice = "price" // La que cambia
        case releaseDate = "releaseDate"
        case currency = "currency"
        case artistName = "artistName"
        case kind = "kind"
        case trackCensoredName = "trackCensoredName"
        case trackViewUrl = "trackViewUrl"
        case trackName = "trackName"
        case trackId = "trackId"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case fileSizeBytes = "fileSizeBytes"
    }
}

//
// MARK: - Equatable Protocol
//

extension Book: Equatable
{
    public static func ==(lhs: Book, rhs: Book) -> Bool
    {
        return lhs.trackName == rhs.trackName
    }

    public static func !=(lhs: Book, rhs: Book) -> Bool
    {
        return !(lhs == rhs)
    }
}

//
// MARK: - CustomStringConvertible Protocol
//

extension Book: CustomStringConvertible
{
    ///
    public var description: String
    {
        return "\(self.trackName) @ \(self.artistName)"
    }
}
