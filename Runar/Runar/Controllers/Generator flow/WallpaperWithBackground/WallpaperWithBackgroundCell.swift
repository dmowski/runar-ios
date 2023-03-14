//
//  WallpaperWithBackgroundCell.swift
//  Runar
//
//  Created by George Stupakov on 22/05/2022.
//

import UIKit

//MARK: Constants
private extension CGFloat {
    static let wallpaperImageTopAnchor = 21.0
    static let wallpaperImageTrailingAnchor = 21.0
    static let wallpaperImageWidth = 22.0
}

class WallpaperWithBackgroundCell: UICollectionViewCell {
    
    
    let selectedCheckbox: UIImageView = {
        let check = UIImageView(image: Assets.selectedCircle.image)
        
        check.contentMode = .scaleAspectFit
        check.isHidden = true
        check.translatesAutoresizingMaskIntoConstraints = false
        
        return check
    }()
    
    let wallpaperImage: UIImageView = {
        let wallpaperImage = UIImageView()
        
        wallpaperImage.contentMode = .scaleAspectFill
        wallpaperImage.layer.cornerRadius = 8
        wallpaperImage.clipsToBounds = true
        wallpaperImage.translatesAutoresizingMaskIntoConstraints = false
        
        return wallpaperImage
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.75
        
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.primaryDarkItemColor.cgColor
        layer.cornerRadius = 8
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(wallpaperImage)
        wallpaperImage.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalToSuperview()
        }
        
        self.addSubview(selectedCheckbox)
        selectedCheckbox.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.wallpaperImageTopAnchor)
            make.trailing.equalToSuperview().inset(CGFloat.wallpaperImageTrailingAnchor)
            make.width.height.equalTo(CGFloat.wallpaperImageWidth)
        }
    }
    
    func selectImage() {
        layer.borderColor = UIColor.yellowSecondaryColor.cgColor
        selectedCheckbox.isHidden = false
    }
    
    func deselectImage() {
        layer.borderColor = UIColor.primaryDarkItemColor.cgColor
        selectedCheckbox.isHidden = true
    }
    
    func setup(image: UIImage?) {
        self.wallpaperImage.image = image
    }
}
