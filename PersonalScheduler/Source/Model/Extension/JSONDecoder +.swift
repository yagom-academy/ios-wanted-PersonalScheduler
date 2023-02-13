//
//  JSONDecoder +.swift
//  PersonalScheduler
//
//  Created by Dragon on 2023/02/10.
//

import UIKit

extension JSONDecoder {
    func decodeData<T: Decodable>(data: Data, to type: T.Type) -> T? {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        var decodedData: T?
        
        do {
            decodedData = try jsonDecoder.decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
        return decodedData
    }
}
