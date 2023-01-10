//
//  AppDelegate.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import FirebaseCore
import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        initKakaoSDK()
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    private func initKakaoSDK() {
        guard let path = Bundle.main.path(forResource: "AppKey", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path),
              let key = dictionary["kakaoAppKey"] as? String else {
            return
        }
    
        KakaoSDK.initSDK(appKey: key, loggingEnable:true)
    }
}

