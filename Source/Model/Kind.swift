//
//  Kind.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 11/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

public enum Kind: String, Codable
{
    case book
    case album
    case coachedAudio
    case featureMovie
    case interactiveBooklet
    case musicVideo
    case pdfPodcast
    case podcastEpisode
    case softwarePackage
    case song
    case tvEpisode
    case artistFor

    /**
        Decodable initializer overrited due to
        diferences between enum values and some
        their json values.
    */
    public init(from decoder: Decoder) throws
    {
        let label: String = try decoder.singleValueContainer().decode(String.self)

        switch label
        {
            case "book":
                self = .book
            case "album":
                self = .album
            case "coached-audio":
                self = .coachedAudio
            case "feature-movie":
                self = .featureMovie
            case "interactive-booklet":
                self = .interactiveBooklet
            case "music-video":
                self = .musicVideo
            case "pdf podcast":
                self = .pdfPodcast
            case "podcast-episode":
                self = .podcastEpisode
            case "software-package":
                self = .softwarePackage
            case "song":
                self = .song
            case "tv-episode":
                self = .tvEpisode
            default:
                self = .artistFor
        }
    }
}
