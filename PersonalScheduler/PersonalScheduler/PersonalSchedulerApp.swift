//
//  PersonalSchedulerApp.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct PersonalSchedulerApp: App {
    
    init() {
        
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
          // Kakao SDK 초기화
          KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        print(kakaoAppKey)
      }
    
    var body: some Scene {
        WindowGroup {
            LoginView().onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
