//
//  TagsCell.swift
//  Runar
//
//  Created by bowtie on 20.06.2022.
//

import UIKit

class TagsCell: UICollectionViewCell {

    static let reuseId = "TagsCell"

    let tagCell: UIView = {
        let tagCell = UIView()
        
        tagCell.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 0.75)
        tagCell.layer.cornerRadius = 8
        tagCell.layer.borderWidth = 1
        tagCell.layer.borderColor = UIColor(red: 0.329, green: 0.329, blue: 0.345, alpha: 0.65).cgColor
        
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
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(tagCell)
        tagCell.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.trailing.equalTo(0)
            make.leading.equalTo(0)
            make.height.equalTo(32)
        }
        
        tagCell.addSubview(runeTag)
        runeTag.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(18)
        }
    }
}
