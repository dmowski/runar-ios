//
//  SelectedLanguageCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension UIColor {
    static let languageNameText = UIColor(red: 0.604, green: 0.604, blue: 0.604, alpha: 1)
}

extension String {
    static let russianCode = "rus"
    static let englishCode = "en"
    static let russian = "Русский"
    static let english = "Английский"
}

class SelectedLanguageCell: UITableViewCell {
    
    static let identifier = "SelectedLanguageCell"
    
    var language: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        configureUI()
        configureTextLabel()
        checkLocalizedLanguage()
        
        button.isSelected = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureTextLabel() {
        
        textLabel?.textAlignment = .left
        textLabel?.textColor = .languageNameText
        textLabel?.font = FontFamily.SFProDisplay.regular.font(size: 16)
    }
    
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(Assets.languageSelected.image, for: .selected)
        button.setImage(Assets.languageUnselected.image, for: .normal)
        return button
    }()

    private func checkLocalizedLanguage() {
        if Locale.current.languageCode == String.englishCode &&
            self.language == String.english ||
            Locale.current.languageCode == String.russianCode &&
            self.language == String.russian {
            
            button.isSelected = true
        }
    }
    
    private func configureUI() {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            button.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
