//
//  LanguageCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension UIColor {
    static let settingsWhiteText = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
}

extension String {
   static let language = "Язык"
}

class LanguageCell: UITableViewCell {
    
    static let identifier = "LanguageCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = FontFamily.SFProDisplay.regular.font(size: 20)
        textLabel?.textColor = .settingsWhiteText
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
