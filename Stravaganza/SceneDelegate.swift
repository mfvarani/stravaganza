//
//  SceneDelegate.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 07/10/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Capture the scene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create UIWindow
        let window = UIWindow(windowScene: windowScene)
        
        // Create view hierarchy & set Root View Controller
        
        if UserDefaults.standard.bool(forKey: "notFirstTime") {
            let viewController = RideTabBarViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
        } else {
            let viewController = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            setNavigationBarAppearance()
            let navigationController = UINavigationController(rootViewController: viewController)
            UserDefaults.standard.set(true, forKey: "notFirstTime")
            window.rootViewController = navigationController
        }
        
        // Set window and call makeKeyAndVisible()
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate {
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .mainOrange
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.abelRegular(size: 24.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

