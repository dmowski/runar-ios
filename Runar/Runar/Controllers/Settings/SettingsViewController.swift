//
//  SettingsViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

final class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        configureUI()
        configureNavigationBar()
    }
    
    private var backgroundImage: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = Assets.Background.main.image
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    private var backgroundShadow: UIImageView = {
        let shadow = UIImageView()
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.image = Assets.Background.backgroundShadowSetting.image
        shadow.contentMode = .scaleAspectFill
        return shadow
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
       
        return tableView
    }()
    
    
    private func configureUI() {
        view.addSubviews(backgroundImage, backgroundShadow)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backgroundShadow.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundShadow.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
        ])
    }

    func configureNavigationBar() {
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true

        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 34.heightDependent())]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)]
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.092, green: 0.092, blue: 0.092, alpha: 0.94)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.092, green: 0.092, blue: 0.092, alpha: 0.94)
        navigationController?.setStatusBar(backgroundColor: UIColor(red: 0.092, green: 0.092, blue: 0.092, alpha: 0.94))
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        switch indexPath.row {
        
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: LanguageCell.language, for: indexPath) as! LanguageCell
        case 1:
            return SelectedLanguageCell(language: String.russian)
        case 2:
            return SelectedLanguageCell(language: String.english)
        case 3:
            return StaticCell(title: .rateApp)
        case 4:
            return StaticCell(title: .aboutApp)

        default:
            return UITableViewCell()
        }

    }
    
    
}
