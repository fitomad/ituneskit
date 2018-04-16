//
//  Artwork.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 9/1/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

public protocol Artwork
{
    /// 100 pixels image
    var artworkUrl100: URL { get }
    /// 60 pixels image 
    var artworkUrl60: URL { get }
}

public extension Artwork
{
    /**
        Create the URL for a custom artwork image size.

        - Parameter imageSize: The new image size required.
    */
    func artworkURL(ofImageSized imageSize: Int) -> URL?
    {
        let newSizeURI: String = self.artworkUrl100.absoluteString.replacingOccurrences(of: "100x100bb", with: "\(imageSize)x\(imageSize)bb")
        
        guard let artworkUrlSize = URL(string: newSizeURI) else
        {
            return nil
        }

        return artworkUrlSize
    }
}
