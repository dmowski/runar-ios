//
//  LanguageCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension UIColor {
    
}

class LanguageCell: UITableViewCell {
    
    static let language = "language"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel?.text = "Язык"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
