//
//  MainCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 17.12.20.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    @IBOutlet var alignmentName: UILabel!
    static let reuseIdentifier = "Cell"
    
    override var isHighlighted: Bool {
            didSet {
                if self.isHighlighted {
                    contentView.layer.backgroundColor = UIColor(red: 1, green: 0.918, blue: 0.792, alpha: 0.15).cgColor
                    contentView.layer.borderColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1).cgColor
                } else {
                    contentView.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
                    contentView.layer.borderColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1).cgColor
                    
                }
            }
    }
    
    override func awakeFromNib() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1).cgColor
        
        contentView.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        
        alignmentName.attributedText = NSMutableAttributedString(string: alignmentName.text!, attributes: [NSAttributedString.Key.kern: -0.72])

        alignmentName.textAlignment = .center


    }
    
    
        func cellFor(indexPath: IndexPath) {
            switch indexPath.item {
            case 0:
                alignmentName.text = "Руна дня"
            case 1:
                alignmentName.text = "Расклад из 2 рун"
            case 2:
                alignmentName.text = "Норны"
            case 3:
                alignmentName.text = "Краткий прогноз"
            case 4:
                alignmentName.text = "Молот Тора"
            case 5:
                alignmentName.text = "Крест"
            case 6:
                alignmentName.text = "Крест стихий"
            case 7:
                alignmentName.text = "Кельтский крест"
    
            default:
                break
            }
        }
}
