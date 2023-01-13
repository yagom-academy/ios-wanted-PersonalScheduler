//
//  Bundle+extension.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation
import OSLog

extension Bundle {
    
    var kakaoAppKey: String? {
        guard let file = self.path(forResource: "Info", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["KakaoAppKey"] as? String else {
            os_log(.error, log: .default, "⛔️ OMDB API KEY를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
    
}
