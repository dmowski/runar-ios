//
//  SceneDelegate.swift
//  Runar
//
//  Created by Oleg Kanatov on 26.01.21.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = getRootViewController()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        window.rootViewController = vc
        UIView.transition(
            with: window,
            duration: 1,
            options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }

    private func getRootViewController() -> UIViewController {
        guard UserDefaults.standard.bool(forKey: "dontShowFirstScreenAgain") else { return FirstScreenVC() }
        guard UserDefaults.standard.bool(forKey: "hasViewedOnboardingScreen") else { return OnboardingScreenVC() }
        return MainTabBarController()
    }
}
