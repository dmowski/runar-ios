//
//  OnboardingScreenCell.swift
//  Runar
//
//  Created by Виталий Татун on 27.07.22.
//

import UIKit

class OnboardingScreenCell: UICollectionViewCell {
        
    let onboardingSlideTitle = UILabel()
    let onboardingDescription = UILabel()
    let onboardingImageView = UIImageView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureOnboardingSlideTitle()
        configureOnboardingDescription()
        configureOnboardingImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureOnboardingCell(with slides: OnboardingSlide) {
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
        onboardingDescription.font = FontFamily.SFProDisplay.regular.font(size: 17)
        onboardingDescription.textColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
        onboardingDescription.textAlignment = .center
        onboardingDescription.numberOfLines = 3
        onboardingDescription.lineBreakMode = .byWordWrapping
        onboardingDescription.backgroundColor = .clear
        contentView.addSubview(onboardingDescription)
        onboardingDescription.snp.makeConstraints { make in
            make.top.equalTo(onboardingSlideTitle.snp.bottom).offset(32)
            make.width.equalTo(230)
            make.height.equalTo(61)
            make.centerX.equalTo(contentView)
        }
    }
    private func configureOnboardingImageView() {
        onboardingImageView.backgroundColor = .clear
        onboardingImageView.contentMode = .scaleAspectFit
        onboardingImageView.backgroundColor = .clear
        contentView.addSubview(onboardingImageView)
        onboardingImageView.snp.makeConstraints { make in
            make.top.equalTo(onboardingDescription.snp.bottom).offset(32)
            make.centerX.equalTo(contentView)
            make.height.width.equalTo(148)
        }
    }
    
   
}
