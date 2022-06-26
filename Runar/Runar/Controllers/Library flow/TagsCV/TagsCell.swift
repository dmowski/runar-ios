//
//  TagsCell.swift
//  Runar
//
//  Created by bowtie on 20.06.2022.
//

import UIKit

class TagsViewCell: UICollectionViewCell {

    static let reuseId = "TagsViewCell"

    let tagCell: UIView = {
        let tagCell = UIView()
        
        tagCell.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 0.75)
        tagCell.layer.cornerRadius = 8
        tagCell.layer.borderWidth = 1
        tagCell.layer.borderColor = UIColor(red: 0.329, green: 0.329, blue: 0.345, alpha: 0.65).cgColor
        tagCell.translatesAutoresizingMaskIntoConstraints = false
        
        return tagCell
    }()

    let runeTag: UILabel = {
        let runeTag = UILabel()
        
        runeTag.font = UIFont.create(withLowSize: 14, withHighSize: 14)
        runeTag.textColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
        runeTag.contentMode = .center
        
        return runeTag
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tagCell)
        
        tagCell.widthAnchor.constraint(equalToConstant: 100).isActive = true
        tagCell.heightAnchor.constraint(equalToConstant: 32).isActive = true
        tagCell.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tagCell.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        tagCell.addSubview(runeTag)
        
        runeTag.translatesAutoresizingMaskIntoConstraints = false
        runeTag.heightAnchor.constraint(equalToConstant: 14).isActive = true
        runeTag.centerXAnchor.constraint(equalTo: tagCell.centerXAnchor).isActive = true
        runeTag.centerYAnchor.constraint(equalTo: tagCell.centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
