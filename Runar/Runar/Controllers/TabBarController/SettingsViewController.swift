//
//  SettingsViewController.swift
//  Runar
//
//  Created by Oleg Kanatov on 10.03.21.
//

import UIKit

class SettingsViewController: UIViewController {


    //-------------------------------------------------
    // MARK: - Variables
    //-------------------------------------------------
    
    private let backgroundDown = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        backgroundViewSetup()
        
    }
    
    
    //-------------------------------------------------
    // MARK: - Background
    //-------------------------------------------------
    
    func setUpNavigationBar() {
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true

        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 34)]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)]
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.092, green: 0.092, blue: 0.092, alpha: 0.94)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.092, green: 0.092, blue: 0.092, alpha: 0.94)
    }
    
    
    func backgroundViewSetup() {
        view.backgroundColor = UIColor(patternImage: Assets.Background.main.image)
        view.contentMode = .scaleAspectFill
        
        
        
        
        backgroundDown.image = Assets.Background.backgroundShadowSetting.image
        backgroundDown.translatesAutoresizingMaskIntoConstraints = false
        backgroundDown.contentMode = .scaleAspectFill
        backgroundDown.isUserInteractionEnabled = true
        self.view.addSubview(backgroundDown)
        NSLayoutConstraint.activate([
            backgroundDown.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundDown.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundDown.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundDown.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
