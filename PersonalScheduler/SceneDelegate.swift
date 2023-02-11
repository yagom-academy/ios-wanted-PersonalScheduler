//
//  SceneDelegate.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/06.
//

import UIKit

import FacebookCore
import KakaoSDKAuth
import FirebaseFirestore
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController: UINavigationController
        if let currentUser = Auth.auth().currentUser {
            let firestore = FireStore()
            let repository = DefaultRepository(dataBase: firestore)
            let service = ScheduleService(repository: repository)
            let rootViewController = ScheduleViewModel(userID: currentUser.uid, service: service)
            navigationController = UINavigationController(rootViewController: rootViewController)
        } else {
            let service = LoginService()
            let viewModel = LoginViewModel(service: service)
            let rootViewController = LoginViewController(viewModel: viewModel)
            navigationController = UINavigationController(rootViewController: rootViewController)
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

