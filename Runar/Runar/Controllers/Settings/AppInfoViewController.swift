//
//  AppInfoViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 13.04.21.
//

import UIKit

extension UIColor {
   static let linkColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
}

extension String {
    static let descriptionAppText = """
            Версия приложения 1.0

            Runar — это приложение для гадания на скандинавских рунах и изучения скандинавской мифологии и сказок. Содержит 8 видов рунных раскладов, толкования рун. В разделе Библиотека вы можете почитать скандинавские саги и сказки.

            С разрешения правообладателей, в приложении использованы следующие музыкальные композиции:
            - Лёдъ (использованы композиции - "Черная Ладья", "Мать моя сказала"), https://lyod1.bandcamp.com/releases
            - Danheim (использованы композиции - "Runar", "Kala"), https://danheimmusic.com
            """
}

class AppInfoViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionView.delegate = self
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigationBar()
    }
    
    private var backgroundShadow: UIImageView = {
        let shadow = UIImageView()
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.image = Assets.Background.backgroundShadowSetting.image
        shadow.contentMode = .scaleAspectFill
        return shadow
    }()
    
    private var backgroundImage: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = Assets.Background.main.image
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    private var descriptionView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        
        let string = String.descriptionAppText
        let firstUrl = "https://lyod1.bandcamp.com/releases"
        let secUrl = "https://danheimmusic.com"
 
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.23
        textView.translatesAutoresizingMaskIntoConstraints = false
        let firstRange = (string as NSString).range(of: firstUrl)
        let secRange = (string as NSString).range(of: secUrl)
        
        let fontSize = DeviceType.iPhoneSE || DeviceType.isIPhone678 ? 16 : 19.heightDependent()
        var attributedText = NSMutableAttributedString(string: string, attributes: [NSMutableAttributedString.Key.paragraphStyle: paragraphStyle,NSMutableAttributedString.Key.font: FontFamily.SFProDisplay.light.font(size: fontSize), NSMutableAttributedString.Key.foregroundColor: UIColor.settingsWhiteText])

        attributedText.addAttribute(.link, value: firstUrl, range: firstRange)
        attributedText.addAttribute(.link, value: secUrl, range: secRange)

        textView.tintColor = .linkColor
        textView.attributedText = attributedText
        

        return textView
    }()
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .settingsTitleColor
        navigationController?.navigationBar.backgroundColor = .navBarBackground
        navigationController?.navigationBar.barTintColor = .navBarBackground
        title = .aboutApp
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 17)]
        
    }
    
    private func configureUI() {
        view.addSubviews(backgroundImage, backgroundShadow, descriptionView)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backgroundShadow.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundShadow.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  24),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -24),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
