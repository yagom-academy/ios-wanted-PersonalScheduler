//
//  Bundle+.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/13.
//

import Foundation


extension Bundle {
    var kakaoAppKey: String {
        guard let file = self.path(forResource: "Info", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["KAKAO_APP_KEY"] as? String else { fatalError("KAKAO_APP_KEY 값을 확인해주세요.")}
        return key
    }
}
