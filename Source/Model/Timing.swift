//
//  Timing.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 13/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

public protocol Timing
{
    /// Duration, in milliseconds, of this track
    /// This info not available for all types
    var trackTimeMillis: Int { get }
}

public extension Timing
{
    /// Track time in a human readable way.
    /// Movies shows hour and minute
    /// Short movies shows minutes and seconds
    /// Songs shows minutes and seconds
    public var fomattedTrackTime: String
    {
        let track_timeinterval: TimeInterval = TimeInterval(self.trackTimeMillis / 1000)
        
        let formatter: DateComponentsFormatter = DateComponentsFormatter()
        formatter.maximumUnitCount = 2
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [ .hour, .minute, .second ]
        formatter.zeroFormattingBehavior = .dropLeading
        
        if let duration = formatter.string(from: track_timeinterval)
        {
            return duration
        }
        
        return "s/n"
    }
}
