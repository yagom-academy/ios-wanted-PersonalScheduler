//
//  Logger.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/13.
//

import Foundation

enum Logger {
    
    static func debug(
        error: Error,
        message: String,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let file = file.components(separatedBy: ["/"]).last ?? ""
        print("\(Date().toString(.log)) [⛔️][\(file)][\(function)][\(line)] -> \(message)")
        debugPrint(error)
    }
    
}
