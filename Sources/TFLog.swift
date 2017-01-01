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

public class Log {

    public enum Level: Int {
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

    public enum Filter {
        case all
        case none
        case tags(Set<String>)
    }

    // MARK: - singleton

    fileprivate static let shared = Log()


    // MARK: - Properties

    /// MinLogLevel: We don't write any log if minLogLevel = nil
    fileprivate var minLevel: Level = .debug

    /// filter what log will be printed.
    fileprivate var filter: Filter = .all

    /**
     Writes the textual representation of `object` and a newline character into the standard output.
     The textual representation is obtained from the `object` using its protocol conformances,
     in the following order of preference: `Streamable`, `Printable`, `DebugPrintable`.
     This function also augments the original function with the filename, function name, and line number of the object that is being logged.
     - parameter object:   A textual representation of the object.
     - parameter tags:   Write log when filter tags contain at least one element in parametter tags.
     - parameter logLevel:   Only write log when logLevel greater than or equal minLogLevel.
     - parameter file:     Defaults to the name of the file that called log().
     - parameter function: Defaults to the name of the function within the file in which log() was called..
     - parameter line:     Defaults to the line number within the file in which log() was called.
     */
    fileprivate func write<T>(_ object: T, tags: Set<String>?, level: Level, file: String, function: String, line: Int) {
        if minLevel.rawValue > level.rawValue {
            return
        }

        var willWriteLog = false
        switch filter {
        case .none:
            return
        case .all:
            willWriteLog = true
        case .tags(let validTags):
            if let tags = tags {
                willWriteLog = validTags.intersection(tags).count > 0
            } else {
                willWriteLog = true
            }
        }

        if willWriteLog {
            let fileString = file as NSString
            let fileLastPathComponent = fileString.lastPathComponent as NSString
            let fileName = fileLastPathComponent.deletingPathExtension
            let logIconString = level.iconString()
            print("\(logIconString) \(fileName).\(function)[\(line)]: \(object)\n", terminator: "")
        }
    }
}


// MARK: - Public API

public extension Log {

    public static func setup(minLevel: Level, filter: Filter) {
        Log.shared.minLevel = minLevel
        Log.shared.filter = filter
    }

    /**
     Writes the textual representation of `object` and a newline character into the standard output.
     The textual representation is obtained from the `object` using its protocol conformances,
     in the following order of preference: `Streamable`, `Printable`, `DebugPrintable`.
     This function also augments the original function with the filename, function name, and line number of the object that is being logged.
     - parameter object:   A textual representation of the object.
     - parameter tags:   Write log when filter tags contain at least one element in parametter tags.
     - parameter file:     Defaults to the name of the file that called log(). Do not override this default.
     - parameter function: Defaults to the name of the function within the file in which log() was called. Do not override this default.
     - parameter line:     Defaults to the line number within the file in which log() was called. Do not override this default.
     */
    public static func verbose<T>(_ object: T, tags: Set<String>? = nil, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.shared.write(object, tags: tags, level: .verbose, file: file, function: function, line: line)
    }

    /**
     Writes the textual representation of `object` and a newline character into the standard output.
     The textual representation is obtained from the `object` using its protocol conformances,
     in the following order of preference: `Streamable`, `Printable`, `DebugPrintable`.
     This function also augments the original function with the filename, function name, and line number of the object that is being logged.
     - parameter object:   A textual representation of the object.
     - parameter tags:   Write log when filter tags contain at least one element in parametter tags.
     - parameter file:     Defaults to the name of the file that called log(). Do not override this default.
     - parameter function: Defaults to the name of the function within the file in which log() was called. Do not override this default.
     - parameter line:     Defaults to the line number within the file in which log() was called. Do not override this default.
     */
    public static func debug<T>(_ object: T, tags: Set<String>? = nil, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.shared.write(object, tags: tags, level: .debug, file: file, function: function, line: line)
    }

    /**
     Writes the textual representation of `object` and a newline character into the standard output.
     The textual representation is obtained from the `object` using its protocol conformances,
     in the following order of preference: `Streamable`, `Printable`, `DebugPrintable`.
     This function also augments the original function with the filename, function name, and line number of the object that is being logged.
     - parameter object:   A textual representation of the object.
     - parameter tags:   Write log when filter tags contain at least one element in parametter tags.
     - parameter file:     Defaults to the name of the file that called log(). Do not override this default.
     - parameter function: Defaults to the name of the function within the file in which log() was called. Do not override this default.
     - parameter line:     Defaults to the line number within the file in which log() was called. Do not override this default.
     */
    public static func info<T>(_ object: T, tags: Set<String>? = nil, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.shared.write(object, tags: tags, level: .info, file: file, function: function, line: line)
    }

    /**
     Writes the textual representation of `object` and a newline character into the standard output.
     The textual representation is obtained from the `object` using its protocol conformances,
     in the following order of preference: `Streamable`, `Printable`, `DebugPrintable`.
     This function also augments the original function with the filename, function name, and line number of the object that is being logged.
     - parameter object:   A textual representation of the object.
     - parameter tags:   Write log when filter tags contain at least one element in parametter tags.
     - parameter file:     Defaults to the name of the file that called log(). Do not override this default.
     - parameter function: Defaults to the name of the function within the file in which log() was called. Do not override this default.
     - parameter line:     Defaults to the line number within the file in which log() was called. Do not override this default.
     */
    public static func warning<T>(_ object: T, tags: Set<String>? = nil, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.shared.write(object, tags: tags, level: .warning, file: file, function: function, line: line)
    }

    /**
     Writes the textual representation of `object` and a newline character into the standard output.
     The textual representation is obtained from the `object` using its protocol conformances,
     in the following order of preference: `Streamable`, `Printable`, `DebugPrintable`.
     This function also augments the original function with the filename, function name, and line number of the object that is being logged.
     - parameter object:   A textual representation of the object.
     - parameter tags:   Write log when filter tags contain at least one element in parametter tags.
     - parameter file:     Defaults to the name of the file that called log(). Do not override this default.
     - parameter function: Defaults to the name of the function within the file in which log() was called. Do not override this default.
     - parameter line:     Defaults to the line number within the file in which log() was called. Do not override this default.
     */
    public static func error<T>(_ object: T, tags: Set<String>? = nil, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.shared.write(object, tags: tags, level: .error, file: file, function: function, line: line)
    }
}
