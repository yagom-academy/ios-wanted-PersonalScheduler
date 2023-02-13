//
//  JSONEncoder +.swift
//  PersonalScheduler
//
//  Created by Dragon on 2023/02/10.
//

import UIKit

extension JSONEncoder {
    func encodeScheduleList(_ dataList: [Schedule]) -> String {
        let optionalDataList = try? JSONEncoder().encode(dataList)
        
        if let data = optionalDataList,
              let dataString = String(data: data, encoding: .utf8) {
            return dataString
        }
        
        return String()
    }
}
