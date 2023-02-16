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
    static let generator = L10n.Tabbar.generator
    static let softLightBlendModeFilter = "softLightBlendMode"
}

class MainTabBarController: UITabBarController {

    private let localNotificationManager: LocalNotificationInterface = LocalNotificationManager()
    private let blurEffectIntensity = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        setupViewControllers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Local Notifications
        localNotificationManager.removeAllNotifications()
        localNotificationManager.addNotification()
    }
    
    private func configureTabBar() {
        UITabBar.appearance().tintColor = Assets.TabBar.pushColor.color
        
        let blurView = CustomIntensityVisualEffectView(effect: UIBlurEffect(style: .dark), intensity: blurEffectIntensity)
        blurView.frame = self.view.bounds
        blurView.contentView.layer.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1).cgColor
        blurView.contentView.layer.compositingFilter = String.softLightBlendModeFilter
        tabBar.addSubview(blurView)
        
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.barTintColor = .white
    }
    
    private func setupViewControllers() {
        let lay = UICollectionViewFlowLayout()
        let runicDrawsVC = RunicDrawsCollectionVC(collectionViewLayout: lay)
        let settingsVC = SettingsVC()
        let libraryVC = LibraryViewController()
        let generatorVC = SelectionRuneVC()
        
        viewControllers = [
            generateTabBarController(rootViewController: runicDrawsVC, image: Assets.TabBar.Image.home.image, title: String.layouts),
            generateTabBarController(rootViewController: libraryVC, image: Assets.TabBar.Image.library.image, title: String.library),
            generateTabBarController(rootViewController: generatorVC, image: Assets.TabBar.Image.generator.image, title: String.generator),
            generateTabBarController(rootViewController: settingsVC, image: Assets.TabBar.Image.settings.image, title: String.settings)
        ]
    }
    
    private func generateTabBarController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        navigationVC.navigationBar.setBackgroundImage(UIImage(), for: .default)

        return navigationVC
    }
}

class CustomIntensityVisualEffectView: UIVisualEffectView {
    
    private var animator: UIViewPropertyAnimator?
    
    init(effect: UIVisualEffect, intensity: CGFloat) {
        super.init(effect: nil)
        
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [weak self] in self?.effect = effect }
        animator?.fractionComplete = intensity
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}



