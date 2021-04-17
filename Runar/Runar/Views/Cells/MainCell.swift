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
    private static let labelBottomMultiplier : CGFloat = 12/199
    private static let labelTopMultiplier: CGFloat = 156/199
    private static let imageLeftMultiplier: CGFloat = 45/183
    var image = UIImageView()
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                contentView.layer.backgroundColor = Assets.CellSettings.Colors.backgroundColorHighlite.color.cgColor
                contentView.layer.borderColor = Assets.CellSettings.Colors.colorLight.color.cgColor
            } else {
                contentView.layer.backgroundColor = Assets.CellSettings.Colors.backgroundColor.color.cgColor
                contentView.layer.borderColor = Assets.CellSettings.Colors.borderColor.color.cgColor
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
        contentView.layer.borderColor = Assets.CellSettings.Colors.borderColor.color.cgColor
        contentView.layer.backgroundColor = Assets.CellSettings.Colors.backgroundColor.color.cgColor
        
    }
    
    func update(with model: MainCellModel?) {
        guard let model = model else { return }
        alignmentLabel.text = model.name
        image.image = model.image
    }
    
    func setUpRune() {
        alignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        alignmentLabel.textColor = Assets.CellSettings.Colors.colorDidLight.color
        alignmentLabel.textAlignment = .center
        alignmentLabel.highlightedTextColor = Assets.CellSettings.Colors.colorLight.color
        alignmentLabel.font = UIFont(name: FontFamily.AmaticSC.bold.family, size: self.frame.size.height * MainCell.fontMultiplier)
        alignmentLabel.adjustsFontSizeToFitWidth = true
        alignmentLabel.minimumScaleFactor = 0.9
        contentView.addSubview(alignmentLabel)
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            alignmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            alignmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            alignmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(self.frame.size.height * MainCell.labelBottomMultiplier)),
            alignmentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (self.frame.size.height * MainCell.labelTopMultiplier)),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (self.frame.size.width * MainCell.imageLeftMultiplier)),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.bottomAnchor.constraint(equalTo: alignmentLabel.topAnchor, constant: -1)
        ])
    }
}

