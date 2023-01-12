//
//  PersonalScheduleApp.swift
//  PersonalSchedule
//
//  Created by seohyeon park on 2023/01/12.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct PersonalScheduleApp: App {
    
    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
