//
//  SceneDelegate.swift
//  Cybotronics-SSO
//
//  Created by Demo User on 21/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        self.window = UIWindow(windowScene: windowScene)
        configureRootView()
    }

    func configureRootView() {
        guard let window = window else {return}
        let rootViewController: UIViewController = UINavigationController(rootViewController: HomeViewController()) 


        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

