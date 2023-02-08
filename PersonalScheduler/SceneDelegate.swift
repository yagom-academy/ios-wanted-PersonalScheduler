//
//  SceneDelegate.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/06.
//

import UIKit

import FacebookCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let rootViewController = LoginViewController(nibName: nil, bundle: nil)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
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

