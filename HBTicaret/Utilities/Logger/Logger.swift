//
//  Logger.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import Foundation

enum LoggerType {
    case info
    case error
    case warning
    
    var icon: String {
        
        switch self {
        case .info:
            return "ℹ️"
        case .error:
            return "❌"
        case .warning:
            return "⚠️"
        }
    }
}

struct Logger {
    
    static func log(text: String, functionName: String = #function, line: Int = #line, type: LoggerType = .info) {
        
        let printText = type.icon + "[HBTicaret]" + "[\(functionName)]" + "[\(line.toString)] " + text
        
        print(printText)
    }
}
