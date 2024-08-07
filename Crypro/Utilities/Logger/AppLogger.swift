//
//  AppLogger.swift
//  Crypro
//
//  Created by Antomated on 08.05.2024.
//

import OSLog

struct AppLogger {
    static var configuration: LogConfiguration = .debugOnly

    static func log(tag: LogTag = .debug, _ items: Any...,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line,
                    separator: String = " ") {
        guard configuration.isEnabled else { return }

        let log = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "App", category: tag.rawValue)
        let shortFileName = URL(fileURLWithPath: file).lastPathComponent

        let output = items.map { item in
            (item as? CustomStringConvertible)?.description ?? "\(item)"
        }.joined(separator: separator)

        let message = "\(tag.label) [\(shortFileName):\(line) \(function)] - \(output)"

        os_log(tag.osLogType, log: log, "%{public}@", message)
    }
}
