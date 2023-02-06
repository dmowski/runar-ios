//
//  OnboardingScreenCell.swift
//  Runar
//
//  Created by Виталий Татун on 27.07.22.
//

import UIKit

class OnboardingScreenCell: UICollectionViewCell {
        
    private let onboardingSlideTitle = UILabel()
    private let onboardingDescription = UILabel()
    private let onboardingImageView = UIImageView()
    
    // MARK: Constants
    // this is a constant, a divider that is calculated from the screen dimensions, for the correct placement of the Description on the screen
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureOnboardingSlideTitle()
        configureOnboardingDescription()
        configureOnboardingImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configureOnboardingCell(with slides: OnboardingSlide) {
        onboardingSlideTitle.text = slides.title
        onboardingImageView.image = slides.image
        onboardingDescription.text = slides.description
    }
    
    private func configureOnboardingSlideTitle() {
        onboardingSlideTitle.font = .amaticBold(size: CGFloat.fontSizeSlideTitle)
        onboardingSlideTitle.textColor = UIColor.yellowPrimaryColor
        onboardingSlideTitle.textAlignment = .center
        onboardingSlideTitle.contentMode = .center
        onboardingSlideTitle.backgroundColor = .clear
        contentView.addSubview(onboardingSlideTitle)
        onboardingSlideTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.height.equalTo(CGFloat.heightSlideTitle)
            make.centerX.equalTo(contentView)
        }
    }
    
    private func configureOnboardingDescription() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = CGFloat.lineHeightMultipleDescription
        onboardingDescription.font = .systemRegular(size: CGFloat.fontDescription)
        onboardingDescription.textColor = UIColor.textColorDescription
        onboardingDescription.attributedText = NSAttributedString(
            string: self.description,
            attributes: [
                NSAttributedString.Key.kern: 0.41,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
        onboardingDescription.textAlignment = .center
        onboardingDescription.numberOfLines = 0
        onboardingDescription.lineBreakMode = .byWordWrapping
        onboardingDescription.backgroundColor = .clear
        contentView.addSubview(onboardingDescription)
        onboardingDescription.snp.makeConstraints { make in
            make.top.equalTo(onboardingSlideTitle.snp.bottom).offset(CGFloat.topAnchorDescription)
            make.height.equalTo(CGFloat.heightDescription)
            make.width.equalTo(CGFloat.widthDescription)
            make.centerX.equalTo(contentView)
            
        }
    }
    
    private func configureOnboardingImageView() {
        onboardingImageView.backgroundColor = .clear
        onboardingImageView.contentMode = .scaleAspectFit
        contentView.addSubview(onboardingImageView)
        onboardingImageView.snp.makeConstraints { make in
            make.top.equalTo(onboardingDescription.snp.bottom).offset(CGFloat.topAnchorImageView)
            make.centerX.equalTo(contentView)
            make.height.width.equalTo(CGFloat.heightImageView)
        }
    }
}

private extension CGFloat {
    static let fontSizeSlideTitle = 36.0
    static let heightSlideTitle = 32.0
    
    static let lineHeightMultipleDescription = 1.08
    static let fontDescription = 17.0
    static let topAnchorDescription = 32.0
    static let heightDescription = 70.0
    static let widthDescription = 260.0
    
    static let topAnchorImageView = 32.0
    static let heightImageView = 148.0
}

private extension UIColor {
    static let textColorDescription = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
}
