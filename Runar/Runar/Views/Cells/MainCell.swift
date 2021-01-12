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
    var image = UIImageView()
    
    
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
    
    private let alignmentLabel = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        setUpRune()
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
    
    func nameFor(indexPath: IndexPath) {
        let data = DataBase()
        alignmentLabel.text = data.namesDataSourse[indexPath.item]
        image.image = UIImage(named: data.namesDataSourse[indexPath.item])
    }
    
    func setUpRune() {
        alignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        alignmentLabel.textColor =  UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        alignmentLabel.textAlignment = .center
        alignmentLabel.highlightedTextColor = UIColor(red: 0.988, green: 0.784, blue: 0.455, alpha: 1)
        alignmentLabel.font = UIFont(name: "AmaticSC-Bold", size: self.frame.size.height * MainCell.fontMultiplier)
        contentView.addSubview(alignmentLabel)
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            alignmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            alignmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            alignmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(self.frame.size.height * MainCell.bottonMultiplier)),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            image.heightAnchor.constraint(equalToConstant: 155 / 199 * self.frame.size.height)
        ])
        
    }
    
    

}
