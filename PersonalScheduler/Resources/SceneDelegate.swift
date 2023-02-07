//
//  SceneDelegate.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url,
              AuthApi.isKakaoTalkLoginUrl(url) else {
            return
        }
        
        _ = AuthController.handleOpenUrl(url: url)
    }
}

