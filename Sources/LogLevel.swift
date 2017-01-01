//
//  LogLevel.swift
//  TFLog
//
//  Created by David on 1/2/17.
//  Copyright © 2017 TFLog. All rights reserved.
//

import Foundation

public extension Log {

    enum LogLevel: Int {
        case verbose
        case debug
        case info
        case warning
        case error

        func iconString() -> String {
            switch self {
            case .verbose:
                return "🐹"
            case .debug:
                return "🐞"
            case .info:
                return "😊"
            case .warning:
                return "💀"
            case .error:
                return "☠"
            }
        }
    }
}
