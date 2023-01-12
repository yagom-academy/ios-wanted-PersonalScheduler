//
//  Encodable+extension.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/09.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

extension Encodable {

    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    func asFirestoreDictionary() throws -> [String: Any] {
        let encoder = Firestore.Encoder()
        let dictionary = try encoder.encode(self)
        return dictionary
    }

    func asURLQuerys() throws -> [URLQueryItem] {
        let dictionary = try asDictionary()
        return dictionary
            .sorted{ $0.key < $1.key }
            .map {
                return URLQueryItem(
                    name: $0.key,
                    value: "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                )
            }
    }

}
