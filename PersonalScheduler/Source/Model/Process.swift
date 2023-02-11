//
//  Process.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/11.
//

import Foundation

enum Process: Hashable {
    case ready
    case complete
}

extension Process: CustomStringConvertible {
    var description: String {
        switch self {
        case .ready:
            return "Ready"
        case .complete:
            return "Complete"
        }
    }
}
