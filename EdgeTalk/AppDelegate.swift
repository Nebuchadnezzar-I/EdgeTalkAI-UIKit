//
//  AppDelegate.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        let initialViewController = ViewController()
        window?.rootViewController = UINavigationController(
            rootViewController: initialViewController)
        window?.makeKeyAndVisible()

        return true
    }
}
