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

final class SettingsVC: UIViewController {
    
    private var tableView = UITableView()
    
    private var backgroundImage: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = Assets.Background.main.image
        background.contentMode = .scaleAspectFill
        return background
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetUps()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
    }
    
    private func tableViewSetUps() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.identifier)
        tableView.register(MusicCell.self, forCellReuseIdentifier: MusicCell.identifier)
        tableView.register(StaticCell.self, forCellReuseIdentifier: StaticCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
    }
    
    private func configureUI() {
        view.addSubviews(backgroundImage, tableView)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.heightDependent()),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func configureNavigationBar() {

        if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
            title = .settings
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.medium.font(size: 34), NSAttributedString.Key.foregroundColor: UIColor.settingsTitleColor]
        } else {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.medium.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor.settingsTitleColor]
            navigationController?.navigationBar.barTintColor = .navBarBackground
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.leftBarButtonItem?.title = .settings

            let label = UILabel()
            label.text = .settings
            label.textColor = .settingsTitleColor
            label.font = FontFamily.SFProDisplay.medium.font(size: 20)
            label.textAlignment = .left
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        }

        navigationController?.navigationBar.backgroundColor = .navBarBackground
        navigationController?.setStatusBar(backgroundColor: .navBarBackground)
    }
}

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        switch indexPath.row {
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier, for: indexPath) as? LanguageCell
            cell?.textLabel?.text = .language
            cell?.openVC = {
                let alert = AlertSettingsVC()
                alert.modalPresentationStyle = .overCurrentContext
                self.navigationController?.present(alert, animated: true, completion: nil)
            }
            return cell ?? LanguageCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MusicCell.identifier, for: indexPath) as? MusicCell
            cell?.textLabel?.text = String.music
            return cell ?? MusicCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: StaticCell.identifier, for: indexPath) as? StaticCell
            cell?.textLabel?.text = String.rateApp
            cell?.openVC = {
                if let url = URL(string: "itms-apps://apple.com/app/") {
                    UIApplication.shared.open(url)}
            }
            return cell ?? StaticCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: StaticCell.identifier, for: indexPath) as? StaticCell
            cell?.textLabel?.text = String.aboutApp
            return cell ?? StaticCell()
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: StaticCell.identifier, for: indexPath) as? StaticCell
            cell?.textLabel?.text = "Monetization"
            return cell ?? StaticCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let alert = AlertSettingsVC()
            alert.modalPresentationStyle = .overCurrentContext
            self.navigationController?.present(alert, animated: true, completion: nil)
        case 2:
            if let url = URL(string: "itms-apps://apple.com/app/1562025468") {
                UIApplication.shared.open(url)
            }
        case 3:
            self.navigationController?.pushViewController(AppInfoVC(), animated: true)
        case 4:
            let monetizationVC = MonetizationVC()
            monetizationVC.modalPresentationStyle = .fullScreen
            self.present(monetizationVC, animated: true, completion: nil)
        default:
            break
        }
    }
}
