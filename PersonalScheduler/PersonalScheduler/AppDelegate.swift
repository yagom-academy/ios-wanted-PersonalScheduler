//
//  AppDelegate.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import SwiftUI
import KakaoSDKCommon

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
      
        return true
    }
    
}
