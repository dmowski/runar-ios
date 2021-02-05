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
    private static let imageLeftMultiplier: CGFloat = 59/183
    var image = UIImageView()
    
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                contentView.layer.backgroundColor = UIColor(red: 1, green: 0.918, blue: 0.792, alpha: 0.15).cgColor
                contentView.layer.borderColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1).cgColor
            } else {
                contentView.layer.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 0.35).cgColor
                contentView.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor

                
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
        contentView.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor

        contentView.layer.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35).cgColor
        
    }

    
    func update(with model: MainCellModel?) {
        guard let model = model else { return }
        alignmentLabel.text = model.name
        image.image = model.image
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
            alignmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(self.frame.size.height * MainCell.labelBottomMultiplier)),
                        alignmentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (self.frame.size.height * MainCell.labelTopMultiplier)),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (self.frame.size.width * MainCell.imageLeftMultiplier)),
                         image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.bottomAnchor.constraint(equalTo: alignmentLabel.topAnchor, constant: -13)
        ])
        
    }
}


private extension RuneDescription {
    var image: UIImage {
        switch layout {
        case .dayRune:
            return Assets.dayRune.image
        case .twoRunes:
            return Assets.twoRunes.image
        case .norns:
            return Assets.norns.image
        case .thorsHummer:
            return Assets.thorsHummer.image
        case .shortPrediction:
            return Assets.shortPrediction.image
        case .cross:
            return Assets.cross.image
        case .elementsCross:
            return Assets.elementsCross.image
        case .keltsCross:
            return Assets.keltsCross.image
        }
    }
}
