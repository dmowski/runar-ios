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
}

class OnboardingView: UIView {
    
    private let onboardigBackgroundImage = UIImageView()
    private let onboardingSkipButton = UIButton()
    var onboardingCollectionView: UICollectionView!
    let onboardingNextSlideButton = CustomButton()
    let pageControllStackView = UIStackView()
    let pageControll = CustomPageControll()
    
    weak var onboardingViewDelegate: OnboardingViewDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackground()
        configureSkipButton()
        configureOnboardingCollectioView()
        configureNextSlideButton()
        configureCustomPageControll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureBackground()
        configureSkipButton()
        configureOnboardingCollectioView()
        configureNextSlideButton()
        configureCustomPageControll()
        
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
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30

        onboardingNextSlideButton.layer.cornerRadius = radiusConstant
        onboardingNextSlideButton.layer.borderWidth = borderConstant
        onboardingNextSlideButton.setTitle(L10n.Onboarding.nextScreen, for: .normal)
        onboardingNextSlideButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        onboardingNextSlideButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        onboardingNextSlideButton.translatesAutoresizingMaskIntoConstraints = false
        onboardingNextSlideButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        onboardingNextSlideButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        onboardingNextSlideButton.setTitleColor(UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1), for: .highlighted)
        addSubview(onboardingNextSlideButton)
        onboardingNextSlideButton.addTarget(self, action: #selector(goToNextSlide), for: .touchUpInside)
        onboardingNextSlideButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(264)
            make.height.equalTo(48)
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.bottom.equalToSuperview().inset(184)
            } else if !DeviceType.iPhoneSE {
                make.bottom.equalToSuperview().inset(130)
            } else {
                make.bottom.equalToSuperview().inset(70)
            }
        }
    }
    
    func configureCustomPageControll() {
        pageControllStackView.axis = .horizontal
        pageControllStackView.distribution = .fillEqually
        pageControllStackView.spacing = 8
        addSubview(pageControllStackView)
        pageControllStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            if !DeviceType.iPhoneSE {
                make.top.equalTo(onboardingNextSlideButton.snp.bottom).offset(67)
            } else {
                make.top.equalTo(onboardingNextSlideButton.snp.bottom).offset(30)
            }
        }
        pageControllStackView.removeFullyAllArrangedSubviews()
        pageControll.numberOfDots = OnboardingSlide.slides().count
        for number in 0..<pageControll.numberOfDots {
             let button = CustomPageControll()
            if pageControll.currentPage == number {
                button.setUpIndicator(size: 8, indicatorColor: UIColor(red: 1, green: 0.753, blue: 0.275, alpha: 1), image: "circle.fill")  //Current page indicator
             } else {
                 button.setUpIndicator(size: 8, indicatorColor: UIColor(red: 1, green: 0.753, blue: 0.275, alpha: 1), image: "circle")  //Page indicator
             }
             pageControllStackView.addArrangedSubview(button)
         }
    }
    
    @objc private func goToNextSlide() {
        onboardingViewDelegate?.nextSlideButton()
    }
    
    @objc private func goToMainScreen() {
        onboardingViewDelegate?.skipButton()
    }
}

extension UIStackView {
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
}
