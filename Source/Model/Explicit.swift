//
//  Explicit.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 13/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

public protocol Explicit
{
    /// Explicitness calification for the collection
    var collectionExplicitness: Explicitness { get }
    /// Explicitness calification just for the track
    var trackExplicitness: Explicitness { get }
}

public extension Explicit
{
    /// Check if track is explicit
    public var isTrackExplicit: Bool
    {
        return self.trackExplicitness == .explicit
    }

    /// Check if collection is explicit
    public var isCollectionExplicit: Bool
    {
        return self.collectionExplicitness == .explicit
    }
}
