//
//  SceneDelegate.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import KakaoSDKAuth
import FacebookCore
import FacebookLogin

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let appDIContainer = AppDIContainer()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        let coordinator = AppCoordinator(
            navigationController: navigationController,
            appDIContainer: appDIContainer
        )
        coordinator.start()
        
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                // MARK: Kakao Login Service
                _ = AuthController.handleOpenUrl(url: url)
            } else {
                // MARK: Facebook Login Service
                ApplicationDelegate.shared.application(
                    UIApplication.shared,
                    open: url,
                    sourceApplication: nil,
                    annotation: [UIApplication.OpenURLOptionsKey.annotation]
                )
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
