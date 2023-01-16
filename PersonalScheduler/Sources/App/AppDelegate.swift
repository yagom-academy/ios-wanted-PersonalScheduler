//
//  AppDelegate.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//
import Firebase
import UIKit
import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        KakaoSDK.initSDK(appKey: "2b313b9cf5e422b415c8e03763f289da")
        
        if #available(iOS 13.0, *) {
            return true
        }
        
        window = UIWindow()
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

