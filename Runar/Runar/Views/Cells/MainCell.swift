//
//  MainCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 17.12.20.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    static let reuseIdentifier = "Cell"
    private static let fontMultiplier : CGFloat = 32/199
    private static let bottonMultiplier : CGFloat = 12/199
    
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
    
    private let alignmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    var text: String? {
        get { alignmentLabel.text }
        set {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 0.62
            alignmentLabel.attributedText = NSMutableAttributedString(string: alignmentLabel.text!, attributes: [NSAttributedString.Key.kern: -0.64, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        setUpAlignmentLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1).cgColor
        contentView.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        
    }
    
    func setUpAlignmentLabel() {
        alignmentLabel.font = UIFont(name: "AmaticSC-Bold", size: self.frame.size.height * MainCell.fontMultiplier)
        contentView.addSubview(alignmentLabel)
        
        NSLayoutConstraint.activate([
            alignmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            alignmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            alignmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(self.frame.size.height * MainCell.bottonMultiplier))
        ])
        
    }
    
    func cellFor(indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            alignmentLabel.text = "Руна дня"
        case 1:
            alignmentLabel.text = "Расклад из 2 рун"
        case 2:
            alignmentLabel.text = "Норны"
        case 3:
            alignmentLabel.text = "Краткий прогноз"
        case 4:
            alignmentLabel.text = "Молот Тора"
        case 5:
            alignmentLabel.text = "Крест"
        case 6:
            alignmentLabel.text = "Крест стихий"
        case 7:
            alignmentLabel.text = "Кельтский крест"
            
        default:
            break
        }
    }
}
