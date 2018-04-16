//
//  Sizing.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 13/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

public protocol Sizing
{
    /// Size in bytes for this iTunes Store item
    var fileSizeBytes: Int { get }
}

public extension Sizing
{
    /// Size in a human readable way
    public var formattedFileSize: String
    {
        ///
        return ByteCountFormatter.string(fromByteCount: Int64(self.fileSizeBytes), countStyle: .file)
    }
}
