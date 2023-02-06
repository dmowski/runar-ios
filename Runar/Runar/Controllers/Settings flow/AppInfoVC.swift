//
//  AppInfoVC.swift
//  Runar
//
//  Created by Юлия Лопатина on 13.04.21.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let sideInset = 24
    static let titleTextSize = CGFloat(36)
    static let lineHeightMultiple = 1.17
    static let descriptionViewTextSize = CGFloat(20)
}

class AppInfoVC: UIViewController, UITextViewDelegate {
    
    private var backgroundImage: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = Assets.Background.mainFire.image.withAlpha(0.45)
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    private var descriptionView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.showsVerticalScrollIndicator = false
        
        let string = L10n.Tabbar.descriptionAppText
        let firstUrl = "https://lyod1.bandcamp.com/releases"
        let secUrl = "https://danheimmusic.com"
 
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = .lineHeightMultiple
        textView.translatesAutoresizingMaskIntoConstraints = false
        let firstRange = (string as NSString).range(of: firstUrl)
        let secRange = (string as NSString).range(of: secUrl)
        
        var attributedText = NSMutableAttributedString(string: string, attributes: [NSMutableAttributedString.Key.paragraphStyle: paragraphStyle, NSMutableAttributedString.Key.font: UIFont.systemLight(size: .descriptionViewTextSize), NSMutableAttributedString.Key.foregroundColor: UIColor.settingsWhiteText])

        attributedText.addAttribute(.link, value: firstUrl, range: firstRange)
        attributedText.addAttribute(.link, value: secUrl, range: secRange)

        textView.tintColor = .yellowPrimaryColor
        textView.attributedText = attributedText

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.amaticBold(size: .titleTextSize), NSAttributedString.Key.foregroundColor: UIColor.yellowPrimaryColor]
        title = .aboutApp
        navigationController?.navigationBar.tintColor = .yellowSecondaryColor
        navigationController?.navigationBar.topItem?.backButtonTitle = L10n.Navbar.Title.back
    }
    
    private func configureUI() {
        view.addSubview(backgroundImage)
        view.addSubview(descriptionView)
        
        backgroundImage.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        descriptionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(CGFloat.sideInset)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
