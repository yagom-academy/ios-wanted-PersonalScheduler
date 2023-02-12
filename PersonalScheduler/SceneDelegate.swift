//
//  SceneDelegate.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/06.
//

import UIKit

import FacebookCore
import KakaoSDKAuth
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let rootViewController = ViewControllerFactory.makeViewController(type: .login)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        if let currentUser = Auth.auth().currentUser {
            let scheduleViewController = ViewControllerFactory.makeViewController(type: .schedule(userID: currentUser.uid))
            navigationController.pushViewController(scheduleViewController, animated: true)
        }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.handleOpenUrl(url: url)
            return
        }
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
}

