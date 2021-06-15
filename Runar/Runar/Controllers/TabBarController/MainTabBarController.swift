//
//  MainTabBarController.swift
//  Runar
//
//  Created by Oleg Kanatov on 10.03.21.
//

import UIKit

extension String {
    static let layouts = L10n.Tabbar.layouts
    static let library = L10n.Tabbar.library
    static let settings = L10n.Tabbar.settings
}

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = Assets.TabBar.pushColor.color
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.98
        blurView.frame = self.view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tabBar.insertSubview(blurView, at: 0)
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = .clear
        
        let lay = UICollectionViewFlowLayout()
        let collectionVC = CollectionViewController(collectionViewLayout: lay)
        let settingsVC = SettingsViewController()
        let libraryVC = LibraryViewController()
        
        viewControllers = [
            generateTabBarController(rootViewController: collectionVC, image: Assets.TabBar.Image.home.image, title: String.layouts),
            generateTabBarController(rootViewController: libraryVC, image: Assets.TabBar.Image.library.image, title: String.library),
            generateTabBarController(rootViewController: settingsVC, image: Assets.TabBar.Image.settings.image, title: String.settings)
        ]
    }
    
    private func generateTabBarController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
//        navigationVC.setNavigationBarHidden(true, animated: false)
        
        return navigationVC
    }
}
