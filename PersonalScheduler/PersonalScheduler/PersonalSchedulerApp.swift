//
//  PersonalSchedulerApp.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import SwiftUI
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct PersonalSchedulerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

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
