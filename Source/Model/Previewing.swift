//
//  Previewing.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 9/1/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

public protocol Previewing
{
    /// URL available if the iTunes Store
    /// item could show a preview of its content.
    /// It should be a movie trailer or song clip.
    var previewURL: URL? { get }
}

public extension Previewing
{    
    /// Check if there are a preview for this item
    public var isPreviewAvailable: Bool
    {
        return self.previewURL != nil
    }
}
