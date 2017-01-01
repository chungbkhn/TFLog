//
//  LogFilter.swift
//  TFLog
//
//  Created by David on 1/2/17.
//  Copyright © 2017 TFLog. All rights reserved.
//

import Foundation

public extension Log {

    enum Filter {
        case all
        case none
        case tags(Set<String>)
    }
}
