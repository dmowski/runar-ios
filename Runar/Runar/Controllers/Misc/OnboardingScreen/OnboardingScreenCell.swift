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
        onboardingSlideTitle.font = FontFamily.AmaticSC.bold.font(size: 36)
        onboardingSlideTitle.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        onboardingSlideTitle.textAlignment = .center
        onboardingSlideTitle.contentMode = .center
        onboardingSlideTitle.backgroundColor = .clear
        contentView.addSubview(onboardingSlideTitle)
        onboardingSlideTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.height.equalTo(32)
            make.centerX.equalTo(contentView)
        }
    }
    
    private func configureOnboardingDescription() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        onboardingDescription.font = FontFamily.SFProDisplay.regular.font(size: 17)
        onboardingDescription.textColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
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
            make.top.equalTo(onboardingSlideTitle.snp.bottom).offset(32)
            make.width.equalTo(230)
            make.height.equalTo(70)
            make.centerX.equalTo(contentView)
        }
    }
    
    private func configureOnboardingImageView() {
        onboardingImageView.backgroundColor = .clear
        onboardingImageView.contentMode = .scaleAspectFit
        contentView.addSubview(onboardingImageView)
        onboardingImageView.snp.makeConstraints { make in
            make.top.equalTo(onboardingDescription.snp.bottom).offset(32)
            make.centerX.equalTo(contentView)
            make.height.width.equalTo(148)
        }
    }
}
