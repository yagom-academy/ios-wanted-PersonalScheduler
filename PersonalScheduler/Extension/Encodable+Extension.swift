//
//  Encodable+Extension.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/11.
//

import Foundation

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: object, options: []) else { return nil }
        guard let dictionary = jsonObject as? [String: Any] else { return nil }
        return dictionary
    }
}
