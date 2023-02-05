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
    let onboardingNextSlideButton = UIButton()
    let onboardingStartButton = UIButton()
    let pageControllStackView = UIStackView()
    let pageControll = CustomPageControll()
    
    // MARK: Constants
    let factorConstant: CGFloat = DeviceType.iPhoneSE ? 0.135 : 0.207
    let heightButton: CGFloat = 48
    let widthButton: CGFloat = 264
    // this is a constant, a multiplier that is calculated from the screen dimensions, for the correct placement of the button on the screen
    
    weak var onboardingViewDelegate: OnboardingViewDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackground()
        configureSkipButton()
        configureOnboardingCollectioView()
        configureNextSlideButton()
        configureCustomPageControll()
        configureOnboardingStartButton()
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
        
<<<<<<< HEAD
        onboardingNextSlideButton.layer.cornerRadius = 8
        onboardingNextSlideButton.layer.borderWidth = 1
=======
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 6.58 : 8
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 24 : 30

        onboardingNextSlideButton.layer.cornerRadius = radiusConstant
        onboardingNextSlideButton.layer.borderWidth = borderConstant
>>>>>>> develop
        onboardingNextSlideButton.setTitle(L10n.Onboarding.nextScreen, for: .normal)
        onboardingNextSlideButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        onboardingNextSlideButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        onboardingNextSlideButton.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        onboardingNextSlideButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 24)
=======
        onboardingNextSlideButton.titleLabel?.font = .amaticBold(size: fontSize)
>>>>>>> develop
        onboardingNextSlideButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        onboardingNextSlideButton.setTitleColor(UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1), for: .highlighted)
        addSubview(onboardingNextSlideButton)
        onboardingNextSlideButton.addTarget(self, action: #selector(goToNextSlide), for: .touchUpInside)
        onboardingNextSlideButton.addTarget(self, action: #selector(changeButtonColor(_:)), for: .touchDown)
        onboardingNextSlideButton.addTarget(self, action: #selector(buttonNormalColor(_:)), for: .touchUpInside)
        onboardingNextSlideButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(widthButton)
            make.height.equalTo(heightButton)
            make.bottom.equalToSuperview().inset(ScreenSize.height * factorConstant)
        }
    }
    
    func configureOnboardingStartButton() {
        
        onboardingStartButton.isHidden = true
        onboardingStartButton.layer.cornerRadius = 8
        onboardingStartButton.layer.borderWidth = 1
        onboardingStartButton.setTitle(L10n.Onboarding.start, for: .normal)
        onboardingStartButton.backgroundColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
        onboardingStartButton.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.7).cgColor
        onboardingStartButton.translatesAutoresizingMaskIntoConstraints = false
        onboardingStartButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 24)
        onboardingStartButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .highlighted)
        onboardingStartButton.setTitleColor(UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1), for: .normal)
        addSubview(onboardingStartButton)
        onboardingStartButton.addTarget(self, action: #selector(goToNextSlide), for: .touchUpInside)
        onboardingStartButton.addTarget(self, action: #selector(changeButtonColor(_:)), for: .touchDown)
        onboardingStartButton.addTarget(self, action: #selector(buttonNormalColor(_:)), for: .touchUpInside)
        onboardingStartButton.snp.makeConstraints { make in
            print(ScreenSize.height)
            make.centerX.equalToSuperview()
            make.width.equalTo(widthButton)
            make.height.equalTo(heightButton)
            make.bottom.equalToSuperview().inset(ScreenSize.height * factorConstant)
        }
    }
    
    func configureCustomPageControll() {
        pageControllStackView.axis = .horizontal
        pageControllStackView.distribution = .fillEqually
        pageControllStackView.spacing = 8
        addSubview(pageControllStackView)
        pageControllStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            let constant = DeviceType.iPhoneSE ? 30 : 67
                make.top.equalTo(onboardingNextSlideButton.snp.bottom).offset(constant)
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
    
    @objc private func buttonNormalColor(_ sender: UIButton) {
        if sender == onboardingStartButton {
            onboardingStartButton.backgroundColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
            onboardingStartButton.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.7).cgColor
        } else {
            onboardingNextSlideButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
            onboardingNextSlideButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        }
    }
    
    @objc private func changeButtonColor(_ sender: UIButton) {
        if sender == onboardingStartButton {
            onboardingStartButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
            onboardingStartButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        } else {
            onboardingNextSlideButton.backgroundColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
            onboardingNextSlideButton.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.7).cgColor
        }
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
