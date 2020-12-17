//
//  MainCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 17.12.20.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    @IBOutlet var alignmentName: UIImageView!
    static let reuseIdentifier = "Cell"
    
    override func awakeFromNib() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.white.cgColor
    }
    
    func cellFor(indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            alignmentName.image = UIImage(named: "Руна дня")
        case 1:
            alignmentName.image = UIImage(named: "Расклад из 2 рун")
        case 2:
            alignmentName.image = UIImage(named:"Норны")
        case 3:
            alignmentName.image = UIImage(named: "Краткий прогноз")
        case 4:
            alignmentName.image = UIImage(named: "Молот Тора")
        case 5:
            alignmentName.image = UIImage(named: "Крест")
        case 6:
            alignmentName.image = UIImage(named: "Крест стихий")
        case 7:
            alignmentName.image = UIImage(named: "Кельтский крест")

        default:
            break
        }
    }
}
