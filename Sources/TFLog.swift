/**
 *  TFLog
 *
 *  Copyright (c) 2017 Chung Duong Van. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import Foundation

struct Log {

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

    static func verbose<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        log(object, logLevel: .verbose, file, function, line)
    }

    static func debug<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        log(object, logLevel: .debug, file, function, line)
    }

    static func info<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        log(object, logLevel: .info, file, function, line)
    }

    static func warning<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        log(object, logLevel: .warning, file, function, line)
    }

    static func error<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        log(object, logLevel: .error, file, function, line)
    }

    /**
     Writes the textual representation of `object` and a newline character into the standard output.
     The textual representation is obtained from the `object` using its protocol conformances,
     in the following order of preference: `Streamable`, `Printable`, `DebugPrintable`.
     This function also augments the original function with the filename, function name, and line number of the object that is being logged.
     - parameter object:   A textual representation of the object.
     - parameter file:     Defaults to the name of the file that called log(). Do not override this default.
     - parameter function: Defaults to the name of the function within the file in which log() was called. Do not override this default.
     - parameter line:     Defaults to the line number within the file in which log() was called. Do not override this default.
     */
    private static func log<T>(_ object: T, logLevel: LogLevel, _ file: String, _ function: String, _ line: Int) {
        let fileString = file as NSString
        let fileLastPathComponent = fileString.lastPathComponent as NSString
        let filename = fileLastPathComponent.deletingPathExtension
        let logIconString = logLevel.iconString()
        print("\(logIconString) \(filename).\(function)[\(line)]: \(object)\n", terminator: "")
    }
}
