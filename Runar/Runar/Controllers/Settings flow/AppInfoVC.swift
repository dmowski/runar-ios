//
//  AppInfoVC.swift
//  Runar
//
//  Created by Юлия Лопатина on 13.04.21.
//

import UIKit

extension UIColor {
   static let linkColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
}

extension String {
    static let descriptionAppText = L10n.Tabbar.descriptionAppText
}

class AppInfoVC: UIViewController, UITextViewDelegate {
    
    private var backgroundImage: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = Assets.Background.main.image.withAlpha(0.45)
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.showsVerticalScrollIndicator = false
        return scrollview
    }()
    
    private var descriptionView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.textContainer.lineBreakMode = .byWordWrapping
        
        let string = String.descriptionAppText
        let firstUrl = "https://lyod1.bandcamp.com/releases"
        let secUrl = "https://danheimmusic.com"
 
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        textView.translatesAutoresizingMaskIntoConstraints = false
        let firstRange = (string as NSString).range(of: firstUrl)
        let secRange = (string as NSString).range(of: secUrl)
        
        var attributedText = NSMutableAttributedString(string: string, attributes: [NSMutableAttributedString.Key.paragraphStyle: paragraphStyle,NSMutableAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 17), NSMutableAttributedString.Key.foregroundColor: UIColor.settingsWhiteText])

        attributedText.addAttribute(.link, value: firstUrl, range: firstRange)
        attributedText.addAttribute(.link, value: secUrl, range: secRange)

        textView.tintColor = .linkColor
        textView.attributedText = attributedText

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionView.delegate = self
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigationBar()
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.topItem?.backButtonTitle = L10n.Navbar.Title.back
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
        view.addSubviews(backgroundImage, scrollView, descriptionView)
        
        let descriptionTopOffset: CGFloat = DeviceType.iPhoneSE || DeviceType.isIPhone678 ? 26 : 52
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: descriptionTopOffset),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  24),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -24),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
