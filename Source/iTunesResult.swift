//
//  iTunesResult.swift
//  iTunesKit
//
//  Created by Adolfo Vera Blasco on 10/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import Foundation

public enum iTunesResult<T>
{
    ///
    case success(items: [T])
    ///
    case error(message: String)
    ///
    case empty
}
