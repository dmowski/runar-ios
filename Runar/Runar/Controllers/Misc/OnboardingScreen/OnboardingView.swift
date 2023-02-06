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
        onboardingSkipButton.titleLabel?.font = .systemRegular(size: CGFloat.fontSizeSkipButton)
        onboardingSkipButton.titleLabel?.tintColor = UIColor.tintColorSkipButton
        addSubview(onboardingSkipButton)
        onboardingSkipButton.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
        onboardingSkipButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(CGFloat.trailingAnchorSkipButton)
            make.top.equalTo(safeAreaLayoutGuide).inset(CGFloat.topAnchorSkipButton)
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
            make.top.equalTo(onboardingSkipButton.snp.bottom).offset(CGFloat.topAnchorCollectionView)
            make.height.equalTo(CGFloat.heightCollectionView)
                make.leading.trailing.equalToSuperview()
            
        }
        self.onboardingCollectionView = collectionView
    }
    
    private func configureNextSlideButton() {
        
        onboardingNextSlideButton.layer.cornerRadius = CGFloat.cornerRadiusSlideButton
        onboardingNextSlideButton.layer.borderWidth = CGFloat.borderWidthSlideButton
        
        onboardingNextSlideButton.setTitle(L10n.Onboarding.nextScreen, for: .normal)
        onboardingNextSlideButton.backgroundColor = UIColor.darkButtomColor
        onboardingNextSlideButton.layer.borderColor = UIColor.yellowPrimaryColor.cgColor
        onboardingNextSlideButton.translatesAutoresizingMaskIntoConstraints = false

        onboardingNextSlideButton.titleLabel?.font = .amaticBold(size: CGFloat.fontSlideButton)

        onboardingNextSlideButton.setTitleColor(UIColor.yellowPrimaryColor, for: .normal)
        onboardingNextSlideButton.setTitleColor(UIColor.lightTitleButtomColor, for: .highlighted)
        addSubview(onboardingNextSlideButton)
        onboardingNextSlideButton.addTarget(self, action: #selector(goToNextSlide), for: .touchUpInside)
        onboardingNextSlideButton.addTarget(self, action: #selector(changeButtonColor(_:)), for: .touchDown)
        onboardingNextSlideButton.addTarget(self, action: #selector(buttonNormalColor(_:)), for: .touchUpInside)
        onboardingNextSlideButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloat.widthButton)
            make.height.equalTo(CGFloat.heightButton)
            make.bottom.equalToSuperview().inset(ScreenSize.height * CGFloat.bottomAnchorSlideButton)
        }
    }
    
    func configureOnboardingStartButton() {
        
        onboardingStartButton.isHidden = true
        onboardingStartButton.layer.cornerRadius = CGFloat.cornerRadiusSlideButton
        onboardingStartButton.layer.borderWidth = CGFloat.borderWidthSlideButton
        onboardingStartButton.setTitle(L10n.Onboarding.start, for: .normal)
        onboardingStartButton.backgroundColor = UIColor.yellowSecondaryColor
        onboardingStartButton.layer.borderColor = UIColor.lightBorderButtomColor.cgColor
        onboardingStartButton.translatesAutoresizingMaskIntoConstraints = false
        
        onboardingStartButton.titleLabel?.font = .amaticBold(size: CGFloat.fontSlideButton)
        
        onboardingStartButton.setTitleColor(UIColor.yellowPrimaryColor, for: .highlighted)
        onboardingStartButton.setTitleColor(UIColor.lightTitleButtomColor, for: .normal)
        addSubview(onboardingStartButton)
        onboardingStartButton.addTarget(self, action: #selector(goToNextSlide), for: .touchUpInside)
        onboardingStartButton.addTarget(self, action: #selector(changeButtonColor(_:)), for: .touchDown)
        onboardingStartButton.addTarget(self, action: #selector(buttonNormalColor(_:)), for: .touchUpInside)
        onboardingStartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloat.widthButton)
            make.height.equalTo(CGFloat.heightButton)
            make.bottom.equalToSuperview().inset(ScreenSize.height * CGFloat.bottomAnchorSlideButton)
        }
    }
    
    func configureCustomPageControll() {
        pageControllStackView.axis = .horizontal
        pageControllStackView.distribution = .fillEqually
        pageControllStackView.spacing = CGFloat.spacingPageControlStackView
        addSubview(pageControllStackView)
        pageControllStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(onboardingNextSlideButton.snp.bottom).offset(CGFloat.topAnchorPageControl)
        }
        pageControllStackView.removeFullyAllArrangedSubviews()
        pageControll.numberOfDots = OnboardingSlide.slides().count
        for number in 0..<pageControll.numberOfDots {
             let button = CustomPageControll()
            if pageControll.currentPage == number {
                button.setUpIndicator(size: CGFloat.sizeIndicator, indicatorColor: UIColor.indicatorColor, image: "circle.fill")  //Current page indicator
             } else {
                 button.setUpIndicator(size: CGFloat.sizeIndicator, indicatorColor: UIColor.indicatorColor, image: "circle")  //Page indicator
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
            onboardingStartButton.backgroundColor = UIColor.yellowSecondaryColor
            onboardingStartButton.layer.borderColor = UIColor.lightBorderButtomColor.cgColor
        } else {
            onboardingNextSlideButton.backgroundColor = UIColor.darkButtomColor
            onboardingNextSlideButton.layer.borderColor = UIColor.yellowPrimaryColor.cgColor
        }
    }
    
    @objc private func changeButtonColor(_ sender: UIButton) {
        if sender == onboardingStartButton {
            onboardingStartButton.backgroundColor = UIColor.darkButtomColor
            onboardingStartButton.layer.borderColor = UIColor.yellowPrimaryColor.cgColor
        } else {
            onboardingNextSlideButton.backgroundColor = UIColor.yellowSecondaryColor
            onboardingNextSlideButton.layer.borderColor = UIColor.lightBorderButtomColor.cgColor
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

private extension CGFloat {
    static let trailingAnchorSkipButton = 24.0
    static let topAnchorSkipButton = 20.0
    static let fontSizeSkipButton = 15.0
    
    static let topAnchorCollectionView = DeviceType.iPhoneSE || DeviceType.isIPhone678 ? 50.0 : 114.0
    static let heightCollectionView = 350.0
    
    static let cornerRadiusSlideButton = 8.0
    static let borderWidthSlideButton = 1.0
    static let fontSlideButton: CGFloat = 24.0
    /// multiplier calculated: the constraint (specified in the figure) to the bottom of the screen divided by the height of the screen
    static let bottomAnchorSlideButton: CGFloat = DeviceType.iPhoneSE ? 0.135 : 0.2
    static let heightButton: CGFloat = 48.0
    static let widthButton: CGFloat = 264.0
    
    static let spacingPageControlStackView = 8.0
    static let topAnchorPageControl = DeviceType.iPhoneSE ? 30 : 67
    static let sizeIndicator = 8.0
}

private extension UIColor {
    static let tintColorSkipButton = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
    static let darkButtomColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
    static let lightTitleButtomColor = UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1)
    static let lightBorderButtomColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.7)
    static let indicatorColor = UIColor(red: 1, green: 0.753, blue: 0.275, alpha: 1)
}
