//
//  Encodable+Extension.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/12.
//

import Foundation

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
