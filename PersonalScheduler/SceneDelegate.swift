//
//  SceneDelegate.swift
//  PersonalScheduler
//
//  Created by bard on 06/01/23.
//

import KakaoSDKAuth
import FacebookCore
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: Properties
    
    var window: UIWindow?
    
    // MARK: - Methods
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.handleOpenUrl(url: url)
        }
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
}
