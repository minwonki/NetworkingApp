//
//  Logger.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

let log = Logger()

class Logger {
    
    init() {
        // TTY = Xcode console
        let ddlog = DDOSLogger.sharedInstance
        ddlog.logFormatter =  LogFormatter()
        
        #if DEBUG
        DDLog.add(ddlog, with: DDLogLevel.verbose)
        #else
        DDLog.add(ddlog, with: DDLogLevel.warning)
        #endif
        
        // File logger
        #if DEBUG
        DDLog.add(DDFileLogger(), with: DDLogLevel.verbose)
        #else
        DDLog.add(DDFileLogger(), with: DDLogLevel.warning)
        #endif
    }
    
    // MARK: Logging
    func error(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        DDLogError(message, file: file, function: function, line: line)
    }
    
    func warning(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        DDLogWarn(message, file: file, function: function, line: line)
    }
    
    func info(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        DDLogInfo(message, file: file, function: function, line: line)
    }
    
    func debug(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        DDLogDebug(message, file: file, function: function, line: line)
    }
    
    func verbose(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        DDLogVerbose(message, file: file, function: function, line: line)
    }
    
    // MARK: Utils
    private func message(from items: [Any]) -> String {
        return items
            .map { String(describing: $0) }
            .joined(separator: " ")
    }
}

extension DDLogFlag {
    public var level: String {
        switch self {
        case DDLogFlag.error: return "❤️ ERROR"
        case DDLogFlag.warning: return "💛 WARNING"
        case DDLogFlag.info: return "💙 INFO"
        case DDLogFlag.debug: return "💚 DEBUG"
        case DDLogFlag.verbose: return "💜 VERBOSE"
        default: return "☠️ UNKNOWN"
        }
    }
}

private class LogFormatter: NSObject, DDLogFormatter {
    public func format(message logMessage: DDLogMessage) -> String? {
        let level = logMessage.flag.level
        let filename = logMessage.fileName
        let line = logMessage.line
        let message = logMessage.message.components(separatedBy: "\n").joined(separator: "\n    ")
        return "\(level) \(filename):\(line) - \(message)"
    }
}
