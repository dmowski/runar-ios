//
//  LibraryRuneCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/30/21.
//

import UIKit

public class LibraryRuneCell: LibraryCell {
    
    // MARK: - Funcs
    public override func bind(node: LibraryNode) -> Void {
        let runeTitle: UILabel = bindRuneTitle(title: node.title!)
        let runeImage: UIImageView = bindRuneImage(url: node.imageUrl!)
        let runeDesc: UILabel = bindRunDescription(description: node.content!)
                
        self.separatorInset = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
        
        runeTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeTitle.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            runeTitle.heightAnchor.constraint(equalToConstant: 24),
            runeTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        runeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeImage.widthAnchor.constraint(equalTo: widthAnchor),
            runeImage.heightAnchor.constraint(equalToConstant: 129),
            runeImage.topAnchor.constraint(equalTo: runeTitle.bottomAnchor, constant: 10),
            runeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        runeDesc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeDesc.centerXAnchor.constraint(equalTo: centerXAnchor),
            runeDesc.topAnchor.constraint(equalTo: runeImage.bottomAnchor, constant: 10),
            runeDesc.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -26),
            runeDesc.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            runeDesc.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
    }
    
    func bindRuneTitle(title: String) -> UILabel {
        let runeTitle = UILabel()
        
        runeTitle.text = title
        runeTitle.font = UIFont.create(withLowSize: 24, withHighSize: 24)
        runeTitle.textColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
        runeTitle.contentMode = .center
        
        addSubview(runeTitle)
                
        return runeTitle
    }
    
    func bindRuneImage(url: String) -> UIImageView {
        let image = UIImage.create(fromUrl: url)
                
        let size: CGSize = CGSize(width: 109, height: 129)
        let render: UIGraphicsImageRenderer = UIGraphicsImageRenderer(size: size)
        
        let resizedImage: UIImage = render.image { (context) in
            image?.draw(in: CGRect(origin: .zero, size: size))
        }
        
        let runeImage: UIImageView = UIImageView(image: resizedImage)
        
        runeImage.contentMode = .scaleAspectFit
        
        addSubview(runeImage)
        
        return runeImage
    }
    
    func bindRunDescription(description: String) -> UILabel {
        let runeDescription = UILabel()
                 
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.23
        
        let fontSize = DeviceType.iPhoneSE || DeviceType.isIPhone678 ? 16 : 19.heightDependent()
        let attributedText = NSMutableAttributedString(string: description, attributes: [
                                                        NSMutableAttributedString.Key.paragraphStyle: paragraphStyle,
                                                        NSMutableAttributedString.Key.font: FontFamily.SFProDisplay.light.font(size: fontSize),
                                                        NSMutableAttributedString.Key.foregroundColor: UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)])

        runeDescription.attributedText = attributedText
        runeDescription.contentMode = .scaleToFill
        runeDescription.numberOfLines = 0
        runeDescription.lineBreakMode = .byWordWrapping
        runeDescription.backgroundColor = .clear
        
        addSubview(runeDescription)
        
        return runeDescription
    }
}
