//
//  OnboardingView.swift
//  Runar
//
//  Created by Виталий Татун on 5.09.22.
//

import UIKit

protocol OnboardingViewDelegateProtocol: AnyObject {
    func skipButton()
    func nextSlideButton()
    func reset()
}

class OnboardingView: UIView {
    let onboardigBackgroundImage = UIImageView()
    let onboardingSkipButton = UIButton()
    var onboardingCollectionView: UICollectionView!
    let onboardingNextSlideButton = CustomButton()
    let onboardingPageControl = UIPageControl()
    
    
    
    // MARK: DELETE(for testing UserDefaults only)
    let resetUserDefaults = UIButton() // Delete after(for test only)
    private func configureResetButton() {
        resetUserDefaults.backgroundColor = .clear
        resetUserDefaults.setTitle("RESET", for: .normal)
        resetUserDefaults.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        resetUserDefaults.titleLabel?.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        addSubview(resetUserDefaults)
        resetUserDefaults.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetUserDefaults.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(safeAreaLayoutGuide).inset(60)
        }
    }
    
    
    weak var onboardingViewDelegate: OnboardingViewDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackground()
        configureSkipButton()
        configureOnboardingCollectioView()
        configureNextSlideButton()
        configureOnboardingPageControll()
        configureResetButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureBackground()
        configureSkipButton()
        configureOnboardingCollectioView()
        configureNextSlideButton()
        configureOnboardingPageControll()
        configureResetButton()

        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackground() {
        onboardigBackgroundImage.image = Assets.Background.mainFire.image
        onboardigBackgroundImage.contentMode = .scaleToFill
        addSubview(onboardigBackgroundImage)
        onboardigBackgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configureSkipButton() {
        onboardingSkipButton.backgroundColor = .clear
        onboardingSkipButton.setTitle(L10n.Onboarding.skip, for: .normal)
        onboardingSkipButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        onboardingSkipButton.titleLabel?.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        addSubview(onboardingSkipButton)
        onboardingSkipButton.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
        onboardingSkipButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    private func configureOnboardingCollectioView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OnboardingScreenCell.self, forCellWithReuseIdentifier: String(describing: OnboardingScreenCell.self))
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                make.top.equalTo(onboardingSkipButton.snp.bottom).offset(114)
                make.height.equalTo(350)
                make.leading.trailing.equalToSuperview()
            } else {
                make.top.equalTo(onboardingSkipButton.snp.bottom).offset(50)
                make.height.equalTo(350)
                make.leading.trailing.equalToSuperview()
            }
        }
        self.onboardingCollectionView = collectionView
    }
    private func configureNextSlideButton() {
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 6.58 : 8
        onboardingNextSlideButton.layer.cornerRadius = radiusConstant
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        onboardingNextSlideButton.layer.borderWidth = borderConstant
        onboardingNextSlideButton.setTitle(L10n.Onboarding.nextScreen, for: .normal)
        onboardingNextSlideButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        onboardingNextSlideButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        onboardingNextSlideButton.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        onboardingNextSlideButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        onboardingNextSlideButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        onboardingNextSlideButton.setTitleColor(UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1), for: .highlighted)
        addSubview(onboardingNextSlideButton)
        onboardingNextSlideButton.addTarget(self, action: #selector(goToNextSlide), for: .touchUpInside)
        onboardingNextSlideButton.snp.makeConstraints { make in
            if DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                make.bottom.equalToSuperview().inset(184)
                make.centerX.equalToSuperview()
                make.width.equalTo(264)
                make.height.equalTo(48)
            } else {
                make.bottom.equalToSuperview().inset(130)
                make.centerX.equalToSuperview()
                make.width.equalTo(264)
                make.height.equalTo(48)
            }
        }
    }
    private func configureOnboardingPageControll() {
        onboardingPageControl.numberOfPages = 6
        onboardingPageControl.currentPageIndicatorTintColor = UIColor(red: 1, green: 0.753, blue: 0.275, alpha: 1)
        onboardingPageControl.isUserInteractionEnabled = false
        addSubview(onboardingPageControl)
        onboardingPageControl.snp.makeConstraints { make in
                make.top.equalTo(onboardingNextSlideButton.snp.bottom).offset(60)
                make.centerX.equalToSuperview()
        }
    }
    
    @objc func goToNextSlide() {
        onboardingViewDelegate?.nextSlideButton()
    }
    
    @objc func goToMainScreen() {
        onboardingViewDelegate?.skipButton()
    }
    
    // For test only
    @objc func reset() {
        onboardingViewDelegate?.reset()
    }
}
