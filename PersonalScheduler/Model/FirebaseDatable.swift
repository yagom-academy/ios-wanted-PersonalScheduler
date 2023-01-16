//
//  FirebaseDatable.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/11.
//

import Foundation

protocol FirebaseDatable: Codable {
    var detailPath: [String] { get }
    static var path: [String] { get }
}

extension FirebaseDatable {
    var arrayPath: [String] {
        var array = self.detailPath
        array.removeLast()
        return array
    }
}
