//
//  MonetizationView.swift
//  Runar
//
//  Created by George Stupakov on 21/07/2022.
//

import UIKit
import SnapKit

protocol MonetizationViewDelegateProtocol: AnyObject {

    func didTapSkipkButton()
    func didTapGoPremiumButton()
    func didTapTermsOfUseButton()
    func didTapPrivacyPolicyButton()
    func didTapRestoreButton()
}

class MonetizationView: UIView {

    private let backgroundImageView = UIImageView()
    private let skipButton = UIButton()

    private let mainImageView = UIImageView()
    private let titleRunarPremium = UILabel()
    private let lineUnder = UIView()

    private let subTitleRunarPremium = UILabel()
    private let firstDescription = MonetizationDescriptionViewBox(text: L10n.Monetization.firstDescriptionTitle)
    private let secondDescription = MonetizationDescriptionViewBox(text: L10n.Monetization.secondDescriptionTitle)
    private let thirdDescription = MonetizationDescriptionViewBox(text: L10n.Monetization.thirdDescriptionTitle)
    private let fourthDescription = MonetizationDescriptionViewBox(text: L10n.Monetization.fourthDescriptionTitle)
    private let mainTitleMonetization = UILabel()
    
    private let stackViewStatusPrice = UIStackView()
    private let salePriceView = MonetizationStatusView(titleLabel: "Sale", descriptionLabel: "Annualy",
                                                       priceLabel: "11,99 USD", subPriceTitle: "одним платежом")
    private let popularPriceView = MonetizationStatusView(titleLabel: "Popular", descriptionLabel: "Monthly",
                                                          priceLabel: "1,99 USD", subPriceTitle: "3 дня бесплатно")
    private let foreverPriceView = MonetizationStatusView(titleLabel: "Forever", descriptionLabel: "Forever",
                                                          priceLabel: "29,99 USD", subPriceTitle: "одним платежом")

    private let goPremiumButton = UIButton()
    private let stackViewButtons = UIStackView()
    private let termsOfUseButton = UIButton()
    private let privacyPolicyButton = UIButton()
    private let restoreButton = UIButton()

    weak var delegate: MonetizationViewDelegateProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBackgroundImage()
        setupSkipButton()
        setupTitleDescriptionMonetization()
        setupDescriptionMonetization()
        setupChoosePriceViewsMonetization()
        setupBottomButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBackgroundImage() {

        backgroundImageView.image = Assets.Background.main.image
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainImageView.image = Assets.mainMonetizationImage.image
        mainImageView.contentMode = .scaleAspectFill
        addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                make.top.equalToSuperview().offset(44)
                make.centerX.equalToSuperview()
                make.size.equalTo(250)
            } else {
                make.top.equalToSuperview().offset(20)
                make.centerX.equalToSuperview()
                make.size.equalTo(150)
            }
        }
    }

    func setupSkipButton() {
        skipButton.setMonetizationTitle(title: L10n.skip,
                                        color: UIColor(red: 0.604, green: 0.604, blue: 0.604, alpha: 1))
        skipButton.titleLabel?.font = FontFamily.SFProDisplay.medium.font(size: 15)
        skipButton.addTarget(self, action: #selector(self.tapSkipButton), for: .touchUpInside)
        addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                make.top.equalToSuperview().offset(74)
                make.trailing.equalToSuperview().offset(-24)
                make.height.equalTo(20)
            } else {
                make.top.equalToSuperview().offset(44)
                make.trailing.equalToSuperview().offset(-24)
                make.height.equalTo(20)
            }
        }
    }

    func setupTitleDescriptionMonetization() {

        titleRunarPremium.textColor = UIColor(red: 1, green: 0.753, blue: 0.275, alpha: 1)
        titleRunarPremium.font = FontFamily.SFProDisplay.bold.font(size: 22)
        titleRunarPremium.textAlignment = .left
        titleRunarPremium.text = L10n.Monetization.title
        addSubview(titleRunarPremium)
        titleRunarPremium.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
        }

        lineUnder.layer.borderWidth = 1.0
        lineUnder.layer.borderColor = UIColor(red: 1, green: 0.753, blue: 0.275, alpha: 1).cgColor
        addSubview(lineUnder)
        lineUnder.snp.makeConstraints { make in
            make.top.equalTo(titleRunarPremium.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(1)
        }

        subTitleRunarPremium.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        subTitleRunarPremium.font = FontFamily.SFProDisplay.bold.font(size: 17)
        subTitleRunarPremium.textAlignment = .left
        subTitleRunarPremium.text = L10n.Monetization.subTitle
        addSubview(subTitleRunarPremium)
        subTitleRunarPremium.snp.makeConstraints { make in
            make.top.equalTo(titleRunarPremium.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
        }
    }
    
    func setupDescriptionMonetization() {

        addSubview(firstDescription)
        firstDescription.snp.makeConstraints { make in
            make.top.equalTo(subTitleRunarPremium.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(22)
        }
        
        addSubview(secondDescription)
        secondDescription.snp.makeConstraints { make in
            make.top.equalTo(firstDescription.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(22)
        }
        
        addSubview(thirdDescription)
        thirdDescription.snp.makeConstraints { make in
            make.top.equalTo(secondDescription.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(22)
        }
        
        addSubview(fourthDescription)
        fourthDescription.snp.makeConstraints { make in
            make.top.equalTo(thirdDescription.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(22)
        }
    }
    
    func setupChoosePriceViewsMonetization() {

        mainTitleMonetization.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        mainTitleMonetization.font = FontFamily.SFProDisplay.bold.font(size: 32)
        mainTitleMonetization.textAlignment = .center
        mainTitleMonetization.text = L10n.Monetization.mainTitleMonetization
        addSubview(mainTitleMonetization)
        mainTitleMonetization.snp.makeConstraints { make in
            make.top.equalTo(fourthDescription.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
        }

        stackViewStatusPrice.addArrangedSubview(salePriceView)
        stackViewStatusPrice.addArrangedSubview(popularPriceView)
        stackViewStatusPrice.addArrangedSubview(foreverPriceView)
        
        stackViewStatusPrice.axis = .horizontal
        stackViewStatusPrice.distribution = .equalCentering
        stackViewStatusPrice.spacing = 6
        addSubview(stackViewStatusPrice)
        stackViewStatusPrice.snp.makeConstraints { make in
            make.top.equalTo(mainTitleMonetization.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
    }

    func setupBottomButtons() {

        goPremiumButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        goPremiumButton.layer.cornerRadius = 8
        goPremiumButton.layer.borderWidth = 1
        goPremiumButton.contentHorizontalAlignment = .center
        goPremiumButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        goPremiumButton.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.7).cgColor
        goPremiumButton.setTitle(title: L10n.Monetization.goPremiumButton, color: UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1))
        goPremiumButton.addTarget(self, action: #selector(self.tapGoPremiunButton), for: .touchUpInside)
        addSubview(goPremiumButton)
        goPremiumButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(264)
            make.height.equalTo(48)
        }

        termsOfUseButton.setMonetizationTitle(title: L10n.Monetization.termsOfUseButton,
                                        color: UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1))
        termsOfUseButton.titleLabel?.font = FontFamily.SFProDisplay.medium.font(size: 13)
        termsOfUseButton.addTarget(self, action: #selector(self.tapTermsOfUseButton), for: .touchUpInside)
        stackViewButtons.addArrangedSubview(termsOfUseButton)

        privacyPolicyButton.setMonetizationTitle(title: L10n.Monetization.privacyPolicyButton,
                                        color: UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1))
        privacyPolicyButton.titleLabel?.font = FontFamily.SFProDisplay.medium.font(size: 13)
        privacyPolicyButton.addTarget(self, action: #selector(self.tapPrivacyPolicyButton), for: .touchUpInside)
        stackViewButtons.addArrangedSubview(privacyPolicyButton)

        restoreButton.setMonetizationTitle(title: L10n.Monetization.restoreButton,
                                        color: UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1))
        restoreButton.titleLabel?.font = FontFamily.SFProDisplay.bold.font(size: 13)
        restoreButton.addTarget(self, action: #selector(self.tapRestoreButton), for: .touchUpInside)
        stackViewButtons.addArrangedSubview(restoreButton)

        stackViewButtons.axis = .horizontal
        stackViewButtons.distribution = .equalSpacing
        stackViewButtons.spacing = 10
        addSubview(stackViewButtons)
        stackViewButtons.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-55)
            make.width.equalTo(264)
            make.height.equalTo(18)
        }
    }
    
    @objc func tapSkipButton() {
        delegate?.didTapSkipkButton()
    }
    
    @objc func tapGoPremiunButton() {
        delegate?.didTapGoPremiumButton()
    }
    
    @objc func tapTermsOfUseButton() {
        delegate?.didTapTermsOfUseButton()
    }
    
    @objc func tapPrivacyPolicyButton() {
        delegate?.didTapPrivacyPolicyButton()
    }

    @objc func tapRestoreButton() {
        delegate?.didTapRestoreButton()
    }
}
