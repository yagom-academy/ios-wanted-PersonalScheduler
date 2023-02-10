//
//  SceneDelegate.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import KakaoSDKAuth
import FirebaseAuth
import FacebookCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let controller = rootViewControllerWithAuthState()
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        if AuthApi.isKakaoTalkLoginUrl(url) {
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

private extension SceneDelegate {
    func rootViewControllerWithAuthState() -> UIViewController {
        let auth = FirebaseAuth.Auth.auth()
        
        guard let _ = auth.currentUser else {
            return LoginViewController()
        }
        
        return ScheduleListViewController()
    }
}
