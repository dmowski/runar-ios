//
//  WallpaperWithBackgroundCell.swift
//  Runar
//
//  Created by George Stupakov on 22/05/2022.
//

import UIKit

class WallpaperWithBackgroundCell: UICollectionViewCell {
    
    let selectedCheckbox: UIImageView = {
        let check = UIImageView(image: Assets.selectedCircle.image)
        
        check.contentMode = .scaleAspectFit
        check.isHidden = true
        
        return check
    }()
    
    let wallpaperImage: UIImageView = {
        let wallpaperImage = UIImageView()
        
        wallpaperImage.contentMode = .scaleAspectFill
        wallpaperImage.layer.cornerRadius = 8
        wallpaperImage.clipsToBounds = true
        
        return wallpaperImage
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.75
        
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1).cgColor
        layer.cornerRadius = 8
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(wallpaperImage)
        
        self.wallpaperImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wallpaperImage.topAnchor.constraint(equalTo: self.topAnchor),
            wallpaperImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            wallpaperImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            wallpaperImage.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        self.addSubview(selectedCheckbox)
        
        self.selectedCheckbox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedCheckbox.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            selectedCheckbox.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -19),
            selectedCheckbox.heightAnchor.constraint(equalToConstant: 22),
            selectedCheckbox.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func selectImage() {
        layer.borderColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1).cgColor
        selectedCheckbox.isHidden = false
    }
    
    func deselectImage() {
        layer.borderColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1).cgColor
        selectedCheckbox.isHidden = true
    }
    
    func setup(image: UIImage?) {
        self.wallpaperImage.image = image
    }
}
