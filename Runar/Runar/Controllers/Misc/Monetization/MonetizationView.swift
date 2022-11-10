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
    func didTapPremiumView()
    func didTapPopularView()
    func didTapEternalView()
    func didTapPayButton()
    func didTapTermsOfUseButton()
    func didTapPrivacyPolicyButton()
    func didTapRestoreButton()
}

class MonetizationView: UIView {
    
    private let heightScreen = UIScreen.main.bounds.height
    private let widthScreen = UIScreen.main.bounds.width

    private let backgroundImageView = UIImageView()
    private let skipButton = UIButton()

    internal let subscriptionMainTitle = UILabel()
    private let descriptionMainTitle = UILabel()
    private let firstDescription = MonetizationDescriptionViewBox(text: L10n.Monetization.firstDescriptionTitle)
    private let secondDescription = MonetizationDescriptionViewBox(text: L10n.Monetization.secondDescriptionTitle)
    private let thirdDescription = MonetizationDescriptionViewBox(text: L10n.Monetization.thirdDescriptionTitle)
    private let fourthDescription = MonetizationDescriptionViewBox(text: L10n.Monetization.fourthDescriptionTitle)
    private let chooseTitleMonetization = UILabel()
    
    private let stackViewStatusPrice = UIStackView()
    private let premiumView = MonetizationStatusView(titleLabel: L10n.Monetization.goPremiumTitle,
                                                     descriptionLabel: L10n.Monetization.goPremiumPeriod,
                                                     priceLabel: L10n.Monetization.goPremiumPrice,
                                                     subPriceTitle: L10n.Monetization.goSubPremiumPrice,
                                                     strikeThrough: false, ifSaleImage: false)
    private let popularView = MonetizationStatusView(titleLabel: L10n.Monetization.goPopularTitle,
                                                     descriptionLabel: L10n.Monetization.goPopularPeriod,
                                                     priceLabel: L10n.Monetization.goPopularPrice,
                                                     subPriceTitle: L10n.Monetization.goSubPopularPrice,
                                                     strikeThrough: true, ifSaleImage: true)
    private let eternalView = MonetizationStatusView(titleLabel: L10n.Monetization.goEternalTitle,
                                                     descriptionLabel: L10n.Monetization.goEternalPeriod,
                                                     priceLabel: L10n.Monetization.goEternalPrice,
                                                     subPriceTitle: L10n.Monetization.goSubEternalPrice,
                                                     strikeThrough: false, ifSaleImage: false)

    private let goPayButton = UIButton()
    private let termsOfUseButton = UIButton()
    private let privacyPolicyButton = UIButton()
    private let restoreButton = UIButton()

    weak var delegate: MonetizationViewDelegateProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tappedPopularSubscription()
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

    private func setupBackgroundImage() {

        backgroundImageView.image = Assets.Background.mainFire.image
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupSkipButton() {

        skipButton.setImage(Assets.escape.image, for: .normal)
        skipButton.addTarget(self, action: #selector(self.tapSkipButton), for: .touchUpInside)
        addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.size.equalTo(48)
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.top.equalToSuperview().offset(58)
            } else {
                make.top.equalToSuperview().offset(26)
            }
        }
    }

    private func setupTitleDescriptionMonetization() {

        subscriptionMainTitle.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        subscriptionMainTitle.font = FontFamily.AmaticSC.bold.font(size: 52)
        subscriptionMainTitle.textAlignment = .center
        addSubview(subscriptionMainTitle)
        subscriptionMainTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.top.equalToSuperview().offset(76)
            } else {
                make.top.equalToSuperview().offset(32)
            }
        }

        descriptionMainTitle.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        descriptionMainTitle.font = FontFamily.AmaticSC.bold.font(size: 36)
        descriptionMainTitle.textAlignment = .center
        descriptionMainTitle.text = L10n.Monetization.descriptionMainTitle
        addSubview(descriptionMainTitle)
        descriptionMainTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.top.equalTo(subscriptionMainTitle.snp.bottom).offset(40)
            } else {
                make.top.equalTo(subscriptionMainTitle.snp.bottom).offset(20)
            }
        }
    }

    private func setupDescriptionMonetization() {

        addSubview(firstDescription)
        firstDescription.snp.makeConstraints { make in
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                make.top.equalTo(descriptionMainTitle.snp.bottom).offset(18)
            } else {
                make.top.equalTo(descriptionMainTitle.snp.bottom).offset(14)
            }
            make.leading.equalTo(descriptionMainTitle.snp.leading)
            make.width.equalTo(260)
            make.height.equalTo(22)
        }
        
        addSubview(secondDescription)
        secondDescription.snp.makeConstraints { make in
            make.top.equalTo(firstDescription.snp.bottom).offset(12)
            make.leading.equalTo(descriptionMainTitle.snp.leading)
            make.width.equalTo(260)
            make.height.equalTo(22)
        }
        
        addSubview(thirdDescription)
        thirdDescription.snp.makeConstraints { make in
            make.top.equalTo(secondDescription.snp.bottom).offset(12)
            make.leading.equalTo(descriptionMainTitle.snp.leading)
            make.width.equalTo(260)
            make.height.equalTo(22)
        }
        
        addSubview(fourthDescription)
        fourthDescription.snp.makeConstraints { make in
            make.top.equalTo(thirdDescription.snp.bottom).offset(12)
            make.leading.equalTo(descriptionMainTitle.snp.leading)
            make.width.equalTo(260)
            make.height.equalTo(22)
        }
    }
    
    private func setupChoosePriceViewsMonetization() {

        chooseTitleMonetization.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        chooseTitleMonetization.font = FontFamily.AmaticSC.bold.font(size: 36)
        chooseTitleMonetization.textAlignment = .center
        chooseTitleMonetization.text = L10n.Monetization.chooseTitleMonetization
        addSubview(chooseTitleMonetization)
        chooseTitleMonetization.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.top.equalTo(fourthDescription.snp.bottom).offset(40)
            } else {
                make.top.equalTo(fourthDescription.snp.bottom).offset(20)
            }
        }
        
        premiumView.addTapGesture{ [weak self] in
            self?.tappedPremiumSubscription()
            self?.delegate?.didTapPremiumView()
        }
        stackViewStatusPrice.addArrangedSubview(premiumView)
        premiumView.snp.makeConstraints { make in
            make.height.equalTo(heightScreen * 0.19)
            make.width.equalTo((widthScreen - 60) / 3)
        }
        
        popularView.addTapGesture{ [weak self] in
            self?.tappedPopularSubscription()
            self?.delegate?.didTapPopularView()
        }
        stackViewStatusPrice.addArrangedSubview(popularView)
        popularView.snp.makeConstraints { make in
            make.height.equalTo(heightScreen * 0.19)
            make.width.equalTo((widthScreen - 60) / 3)
        }
        
        eternalView.addTapGesture{ [weak self] in
            self?.tappedEternalSubscription()
            self?.delegate?.didTapEternalView()
        }
        stackViewStatusPrice.addArrangedSubview(eternalView)
        eternalView.snp.makeConstraints { make in
            make.height.equalTo(heightScreen * 0.19)
            make.width.equalTo((widthScreen - 60) / 3)
        }
        
        stackViewStatusPrice.axis = .horizontal
        stackViewStatusPrice.distribution = .equalSpacing
        stackViewStatusPrice.spacing = 4
        addSubview(stackViewStatusPrice)
        stackViewStatusPrice.snp.makeConstraints { make in
            make.top.equalTo(chooseTitleMonetization.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }

    private func setupBottomButtons() {

        goPayButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        goPayButton.layer.cornerRadius = 8
        goPayButton.layer.borderWidth = 1
        goPayButton.contentHorizontalAlignment = .center
        goPayButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        goPayButton.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.7).cgColor
        goPayButton.setTitle(title: L10n.Monetization.goPay, color: UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1))
        goPayButton.addTarget(self, action: #selector(self.tapGoPremiunButton), for: .touchUpInside)
        addSubview(goPayButton)
        goPayButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackViewStatusPrice.snp.bottom).offset(32)
            make.width.equalTo(264)
            make.height.equalTo(48)
        }

        privacyPolicyButton.setTitle(L10n.Monetization.privacyPolicyButton, for: .normal)
        privacyPolicyButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .normal)
        privacyPolicyButton.titleLabel?.font = FontFamily.SFProDisplay.medium.font(size: 13)
        privacyPolicyButton.titleLabel?.numberOfLines = 2
        privacyPolicyButton.titleLabel?.lineBreakMode = .byWordWrapping
        privacyPolicyButton.titleLabel?.textAlignment = .center
        privacyPolicyButton.addTarget(self, action: #selector(self.tapPrivacyPolicyButton), for: .touchUpInside)
        addSubview(privacyPolicyButton)
        privacyPolicyButton.snp.makeConstraints { make in
            make.top.equalTo(goPayButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        
        termsOfUseButton.setTitle(L10n.Monetization.termsOfUseButton, for: .normal)
        termsOfUseButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .normal)
        termsOfUseButton.titleLabel?.font = FontFamily.SFProDisplay.medium.font(size: 13)
        termsOfUseButton.titleLabel?.numberOfLines = 2
        termsOfUseButton.titleLabel?.lineBreakMode = .byWordWrapping
        termsOfUseButton.titleLabel?.textAlignment = .center
        termsOfUseButton.addTarget(self, action: #selector(self.tapTermsOfUseButton), for: .touchUpInside)
        addSubview(termsOfUseButton)
        termsOfUseButton.snp.makeConstraints { make in
            make.trailing.equalTo(privacyPolicyButton.snp.leading).offset(-20)
            make.centerY.equalTo(privacyPolicyButton)
            make.height.equalTo(36)
        }
        
        restoreButton.setTitle(L10n.Monetization.restoreButton, for: .normal)
        restoreButton.setTitleColor(UIColor(red: 0.930, green: 0.800, blue: 0.570, alpha: 1), for: .normal)
        restoreButton.titleLabel?.font = FontFamily.SFProDisplay.bold.font(size: 13)
        restoreButton.titleLabel?.numberOfLines = 2
        restoreButton.titleLabel?.lineBreakMode = .byWordWrapping
        restoreButton.titleLabel?.textAlignment = .center
        restoreButton.addTarget(self, action: #selector(self.tapRestoreButton), for: .touchUpInside)
        addSubview(restoreButton)
        restoreButton.snp.makeConstraints { make in
            make.leading.equalTo(privacyPolicyButton.snp.trailing).offset(20)
            make.centerY.equalTo(privacyPolicyButton)
            make.height.equalTo(36)
        }
    }
    
    private func tappedPremiumSubscription() {
        subscriptionMainTitle.text = L10n.Monetization.titleSubscriptionPremium
        premiumView.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        popularView.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        eternalView.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        premiumView.lineUnder.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        popularView.lineUnder.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        eternalView.lineUnder.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        premiumView.topChoosedView.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        popularView.topChoosedView.backgroundColor = .clear
        eternalView.topChoosedView.backgroundColor = .clear
        premiumView.titleLabel.textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        popularView.titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        eternalView.titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func tappedPopularSubscription() {
        subscriptionMainTitle.text = L10n.Monetization.titleSubscriptionPopular
        premiumView.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        popularView.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        eternalView.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        premiumView.lineUnder.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        popularView.lineUnder.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        eternalView.lineUnder.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        premiumView.topChoosedView.backgroundColor = .clear
        popularView.topChoosedView.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        eternalView.topChoosedView.backgroundColor = .clear
        premiumView.titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        popularView.titleLabel.textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        eternalView.titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func tappedEternalSubscription() {
        subscriptionMainTitle.text = L10n.Monetization.titleSubscriptionEternal
        premiumView.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        popularView.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        eternalView.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        premiumView.lineUnder.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        popularView.lineUnder.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        eternalView.lineUnder.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        premiumView.topChoosedView.backgroundColor = .clear
        popularView.topChoosedView.backgroundColor = .clear
        eternalView.topChoosedView.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        premiumView.titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        popularView.titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        eternalView.titleLabel.textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
    }
    
    @objc private func tapSkipButton() {
        delegate?.didTapSkipkButton()
    }
    
    @objc private func tapGoPremiunButton() {
        delegate?.didTapPayButton()
    }
    
    @objc private func tapTermsOfUseButton() {
        delegate?.didTapTermsOfUseButton()
    }
    
    @objc private func tapPrivacyPolicyButton() {
        delegate?.didTapPrivacyPolicyButton()
    }

    @objc private func tapRestoreButton() {
        delegate?.didTapRestoreButton()
    }
}
