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
        let collectionView: UICollectionView = bindTagsCV(with: tags)
        let runeDesc: UILabel = bindRunDescription(description: content)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
        
        runeTitle.translatesAutoresizingMaskIntoConstraints = false
        runeTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.runTitleTopAnchor)
            make.height.equalTo(CGFloat.runeTitleHeight)
            make.centerX.equalToSuperview()
        }
        
        runeImage.translatesAutoresizingMaskIntoConstraints = false
        runeImage.snp.makeConstraints { make in
            make.top.equalTo(runeTitle.snp.bottom).offset(CGFloat.runeImageTopAnchor)
            make.centerX.equalToSuperview()
        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(runeImage.snp.bottom).offset(CGFloat.collectionViewTopAnchor)
            make.height.equalTo(tags.isEmpty ? 0 : CGFloat.collectionViewHeight)
            make.trailing.leading.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        runeDesc.translatesAutoresizingMaskIntoConstraints = false
        runeDesc.snp.makeConstraints { make in
            make.top.equalTo(runeImage.snp.bottom).offset(tags.isEmpty ? CGFloat.runeDescTopAnchorWithOutTagsCV : CGFloat.runeDescTopAnchorWithTagsCV)
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(CGFloat.runeDescTrailigLeadingAnchor)
            make.bottom.equalToSuperview().inset(CGFloat.runeDescBottomAnchor)
        }
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
        
        let size: CGSize = CGSize(width: CGFloat.runeImageWidth, height: CGFloat.runeImageHeight)
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
    
    static let runeImageTopAnchor = 10.0
    static let runeImageHeight = 129.0
    static let runeImageWidth = 109.0
    
    static let collectionViewTopAnchor = 16.0
    static let collectionViewHeight = 32.0
    
    static let runeDescTopAnchorWithTagsCV = 74.0
    static let runeDescTopAnchorWithOutTagsCV = 16.0
    static let runeDescTrailigLeadingAnchor = 24.0
    static let runeDescBottomAnchor = 34.0
    static let runeDescFontSize = DeviceType.iPhoneSE || DeviceType.isIPhone678 ? 16.0 : 19.0
}

private extension UIColor {
    // Add to color common class
    static let runeDescColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
}
