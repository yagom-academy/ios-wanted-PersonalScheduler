//
//  AppDelegate.swift
//  PersonalScheduler
//
//  Created by bard on 06/01/23.
//

import KakaoSDKCommon
import KakaoSDKAuth
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication.LaunchOptionsKey: Any
        ]?
    ) -> Bool {
        
        KakaoSDK.initSDK(appKey: "fe804dea611bd7274a600e42ed515f50")

        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                return AuthController.handleOpenUrl(url: url)
            }

            return false
        }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {

        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
    
}

