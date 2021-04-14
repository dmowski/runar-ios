//
//  SettingsViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension UIColor {
    static let navBarBackground = UIColor(red: 0.092, green: 0.092, blue: 0.092, alpha: 0.94)
    static let settingsTitleColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
}

final class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetUps()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    private var tableView = UITableView()
    
    private func tableViewSetUps() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.identifier)
        tableView.register(SelectedLanguageCell.self, forCellReuseIdentifier: SelectedLanguageCell.identifier)
        tableView.register(MusicCell.self, forCellReuseIdentifier: MusicCell.identifier)
        tableView.register(StaticCell.self, forCellReuseIdentifier: StaticCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
    }
    
    
    private func configureUI() {
        view.addSubviews(backgroundImage, backgroundShadow, tableView)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backgroundShadow.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundShadow.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.heightDependent()),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func configureNavigationBar() {
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 34.heightDependent())]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.settingsTitleColor]
        navigationController?.navigationBar.backgroundColor = .navBarBackground
        navigationController?.setStatusBar(backgroundColor: .navBarBackground)
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        switch indexPath.row {
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier, for: indexPath)
            cell.textLabel?.text = .language
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectedLanguageCell.identifier, for: indexPath) as? SelectedLanguageCell
            cell?.textLabel?.text = .russian
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            return cell ?? SelectedLanguageCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectedLanguageCell.identifier, for: indexPath) as? SelectedLanguageCell
            cell?.textLabel?.text = .english
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            return cell ?? SelectedLanguageCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: MusicCell.identifier, for: indexPath) as? MusicCell
            cell?.textLabel?.text = String.music
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            return cell ?? SelectedLanguageCell()
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: StaticCell.identifier, for: indexPath) as? StaticCell
            cell?.textLabel?.text = String.rateApp
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            cell?.openVC = {
                if let url = URL(string: "itms-apps://apple.com/app/") {
                    UIApplication.shared.open(url)}
            }
            return cell ?? SelectedLanguageCell()
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: StaticCell.identifier, for: indexPath) as? StaticCell
            cell?.textLabel?.text = String.aboutApp
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            cell?.openVC = {
                self.navigationController?.pushViewController(AppInfoViewController(), animated: true)}
            return cell ?? SelectedLanguageCell()
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 50
        case 1:
            return 31
        case 2:
            return 31
        case 3:
            return 50
        case 4:
            return 50
        case 5:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 4:
            if let url = URL(string: "itms-apps://apple.com/app/") {
                UIApplication.shared.open(url)
            }
        case 5:
            self.navigationController?.pushViewController(AppInfoViewController(), animated: true)
        default:
            break
        }
    }
    
}
