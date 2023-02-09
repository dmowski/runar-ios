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
        
        guard let title = node.title,
              let imageUrl = node.imageUrl,
              let tags = node.tags,
              let content = node.content else { return }
        
        let runeTitle: UILabel = bindRuneTitle(title: title)
        let runeImage: UIImageView = bindRuneImage(url: imageUrl)
        let tagsCV: UICollectionView = bindTagsCV(with: tags)
        let runeDesc: UILabel = bindRunDescription(description: content)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
        
        runeTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeTitle.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.runTitleTopAnchor),
            runeTitle.heightAnchor.constraint(equalToConstant: CGFloat.runeTitleHeight),
            runeTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        runeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeImage.widthAnchor.constraint(equalTo: widthAnchor),
            runeImage.heightAnchor.constraint(equalToConstant: CGFloat.runeImageHeight),
            runeImage.topAnchor.constraint(equalTo: runeTitle.bottomAnchor, constant: CGFloat.runeImageTopAnchor),
            runeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        tagsCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagsCV.centerXAnchor.constraint(equalTo: centerXAnchor),
            tagsCV.topAnchor.constraint(equalTo: runeImage.bottomAnchor, constant: CGFloat.tagsCVTopAnchor),
            tagsCV.leftAnchor.constraint(equalTo: leftAnchor),
            tagsCV.rightAnchor.constraint(equalTo: rightAnchor),
            tagsCV.heightAnchor.constraint(greaterThanOrEqualToConstant: tags.count == 0 ? 0 : 32)
        ])
        
        runeDesc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeDesc.centerXAnchor.constraint(equalTo: centerXAnchor),
            runeDesc.topAnchor.constraint(equalTo: tagsCV.bottomAnchor, constant: CGFloat.runeDescTopAnchor),
            runeDesc.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat.runeDescBottomAnchor),
            runeDesc.leftAnchor.constraint(equalTo: leftAnchor, constant: CGFloat.runeDescLeftAnchor),
            runeDesc.rightAnchor.constraint(equalTo: rightAnchor, constant: CGFloat.runeDescRightAnchor)
        ])
    }
    
    func bindRuneTitle(title: String) -> UILabel {
        let runeTitle = UILabel()
        
        runeTitle.text = title
        runeTitle.font = .systemRegular(size: CGFloat.runeTitleFontSize)
        runeTitle.textColor = UIColor.yellowSecondaryColor
        runeTitle.contentMode = .center
        
        addSubview(runeTitle)
        
        return runeTitle
    }
    
    func bindRuneImage(url: String) -> UIImageView {
        let image = UIImage.create(fromUrl: url)
        
        let size: CGSize = CGFloat.runeImageSize
        let render: UIGraphicsImageRenderer = UIGraphicsImageRenderer(size: size)
        
        let resizedImage: UIImage = render.image { (context) in
            image?.draw(in: CGRect(origin: .zero, size: size))
        }
        
        let runeImage: UIImageView = UIImageView(image: resizedImage)
        
        runeImage.contentMode = .scaleAspectFit
        
        addSubview(runeImage)
        
        return runeImage
    }
    
    func bindTagsCV(with tags: [String]) -> UICollectionView {
        let tagsCV = TagsCollectionView()
        tagsCV.cells = tags
        
        addSubview(tagsCV)
        
        return tagsCV
    }
    
    func bindRunDescription(description: String) -> UILabel {
        let runeDescription = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.23
        
        let attributedText = NSMutableAttributedString(string: description, attributes: [
            NSMutableAttributedString.Key.paragraphStyle: paragraphStyle,
            NSMutableAttributedString.Key.font: UIFont.systemLight(size: CGFloat.runeDescFontSize),
            NSMutableAttributedString.Key.foregroundColor: UIColor.runeDescColor])
        
        runeDescription.attributedText = attributedText
        runeDescription.contentMode = .scaleToFill
        runeDescription.numberOfLines = 0
        runeDescription.lineBreakMode = .byWordWrapping
        runeDescription.backgroundColor = .clear
        
        addSubview(runeDescription)
        
        return runeDescription
    }
}

private extension CGFloat {
    static let runTitleTopAnchor = 15.0
    static let runeTitleHeight = 26.0
    static let runeTitleFontSize = 24.0
    
    static let runeImageHeight = 129.0
    static let runeImageTopAnchor = 10.0
    static let runeImageSize = CGSize(width: 109, height: 129)
    
    static let tagsCVTopAnchor = 10.0
    
    static let runeDescTopAnchor = 10.0
    static let runeDescBottomAnchor = -26.0
    static let runeDescLeftAnchor = 24.0
    static let runeDescRightAnchor = -24.0
    static let runeDescFontSize = DeviceType.iPhoneSE || DeviceType.isIPhone678 ? 16.0 : 19.0
}

private extension UIColor {
    static let runeDescColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
}
