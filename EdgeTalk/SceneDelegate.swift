//
//  SceneDelegate.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let initialViewController = ViewController()
        window?.rootViewController = UINavigationController(
            rootViewController: initialViewController)
        window?.makeKeyAndVisible()
    }
}
