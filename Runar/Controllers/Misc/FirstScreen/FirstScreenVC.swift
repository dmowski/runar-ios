//
//  FirstScreenVC.swift
//  Runar
//
//  Created by Alexey Poletaev on 18.10.2022.
//

import UIKit

final class FirstScreenVC: UIViewController {

    // MARK: - UI Elements
    private let backgroundImage = UIImageView()
    private let mainImage = UIImageView()
    private let topLabel = UILabel()
    private let mediumLabel = UILabel()
    private let bottomLabel = UILabel()
    private let nextButton = UIButton()
    private let checkBoxButton = UIButton()
    private let checkBoxLabel = UILabel()

    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIElements()
    }

    // MARK: - Methods
    private func configureUIElements() {
        configureBackgroundImage()
        configureMainImage()
        configureTopLabel()
        configureMediumLabel()
        configureButtomLabel()
        configureNextButton()
        configureCheckBoxButton()
        configureCheckBoxLabel()
    }

    private func configureBackgroundImage() {
        backgroundImage.image = Assets.Background.main.image
        backgroundImage.contentMode = .scaleAspectFill

        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configureMainImage() {
        let kHeight = 0.26
        let kWidth = 0.41
        let kTopAlignment = 0.1

        let width = view.frame.width * kWidth
        let height = view.frame.height * kHeight
        let topAlignment = view.frame.height * kTopAlignment

        mainImage.image = Assets.odin.image
        mainImage.contentMode = .scaleAspectFill

        view.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topAlignment)
            make.centerX.equalToSuperview()
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }

    private func configureTopLabel() {
        let kTopAlignment = 0.043
        let kLeftAlignment = 0.07
        let kRightAlignment = -0.07

        let fontSize: CGFloat = DeviceType.iPhoneSE ? 20 : 28
        let topAlignment = view.frame.height * kTopAlignment
        let leftAlignment = view.frame.width * kLeftAlignment
        let rightAlignment = view.frame.width * kRightAlignment

        topLabel.text = L10n.FirstScreen.TopLabel.title
        topLabel.font = FontFamily.AmaticSC.bold.font(size: fontSize)
        topLabel.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        topLabel.textAlignment = .center

        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(topAlignment)
            make.left.equalToSuperview().offset(leftAlignment)
            make.right.equalToSuperview().offset(rightAlignment)
        }
    }

    private func configureMediumLabel() {
        let kLeftAlignment = 0.07
        let kRightAlignment = -0.07

        let fontSize: CGFloat = DeviceType.iPhoneSE ? 30 : 38
        let leftAlignment = view.frame.width * kLeftAlignment
        let rightAlignment = view.frame.width * kRightAlignment

        mediumLabel.text = L10n.FirstScreen.MediumLabel.title
        mediumLabel.font = FontFamily.AmaticSC.bold.font(size: fontSize)
        mediumLabel.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        mediumLabel.textAlignment = .center
        mediumLabel.numberOfLines = 0

        view.addSubview(mediumLabel)
        mediumLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(leftAlignment)
            make.right.equalToSuperview().offset(rightAlignment)
        }
    }

    private func configureButtomLabel() {
        let kTopAlignment = 0.09
        let kLeftAlignment = 0.07
        let kRightAlignment = -0.07

        let fontSize: CGFloat = DeviceType.iPhoneSE ? 18 : 24
        let topAlignment = view.frame.height * kTopAlignment
        let leftAlignment = view.frame.width * kLeftAlignment
        let rightAlignment = view.frame.width * kRightAlignment

        bottomLabel.text = L10n.FirstScreen.ButtomLabel.title
        bottomLabel.font = FontFamily.AmaticSC.bold.font(size: fontSize)
        bottomLabel.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        bottomLabel.textAlignment = .center

        view.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(mediumLabel.snp.bottom).offset(topAlignment)
            make.left.equalToSuperview().offset(leftAlignment)
            make.right.equalToSuperview().offset(rightAlignment)
        }
    }

    private func configureNextButton() {
        let kTopAlignment = 0.018
        let kLeftAlignment = 0.285
        let kRightAlignment = -0.285

        let topAlignment = view.frame.height * kTopAlignment
        let leftAlignment = view.frame.width * kLeftAlignment
        let rightAlignment = view.frame.width * kRightAlignment

        nextButton.setTitle(title: L10n.FirstScreen.NextButton.title)
        nextButton.titleLabel?.font = UIFont(font: FontFamily.AmaticSC.bold, size: 24)
        nextButton.layer.cornerRadius = 8
        nextButton.layer.borderWidth = 1
        nextButton.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        nextButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)

        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(bottomLabel.snp.bottom).offset(topAlignment)
            make.left.equalToSuperview().offset(leftAlignment)
            make.right.equalToSuperview().offset(rightAlignment)
            make.height.equalTo(50)
        }
    }

    private func configureCheckBoxButton() {
        let kTopAlignment = 0.068
        let kLeftAlignment = 0.24

        let topAlignment = view.frame.height * kTopAlignment
        let leftAlignment = view.frame.width * kLeftAlignment

        checkBoxButton.setBackgroundImage(Assets.checkBoxIsOff.image, for: .normal)
        checkBoxButton.setBackgroundImage(Assets.checkBoxIsOn.image, for: .selected)
        checkBoxButton.addTarget(self, action: #selector(checkBoxButtonPressed), for: .touchUpInside)
        view.addSubview(checkBoxButton)
        checkBoxButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(topAlignment)
            make.left.equalToSuperview().offset(leftAlignment)
            make.height.width.equalTo(22)
        }
    }

    private func configureCheckBoxLabel() {
        let kRightAlignment = -0.24

        let fontSize: CGFloat = DeviceType.iPhoneSE ? 13 : 16
        let rightAlignment = view.frame.width * kRightAlignment

        checkBoxLabel.text = L10n.FirstScreen.CheckBoxLabel.title
        checkBoxLabel.font = FontFamily.AmaticSC.bold.font(size: fontSize)
        checkBoxLabel.textColor = UIColor(red: 0.592, green: 0.588, blue: 0.612, alpha: 1)
        checkBoxLabel.textAlignment = .center

        view.addSubview(checkBoxLabel)
        checkBoxLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkBoxButton.snp.centerY)
            make.left.equalTo(checkBoxButton.snp.right).offset(7)
            make.right.equalToSuperview().offset(rightAlignment)
        }
    }

    @objc private func checkBoxButtonPressed() {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
        let colorIsSelected = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
        let colorIsNotSelected = UIColor(red: 0.592, green: 0.588, blue: 0.612, alpha: 1)
        checkBoxLabel.textColor = checkBoxButton.isSelected ? colorIsSelected : colorIsNotSelected
    }

    @objc private func nextButtonPressed() {
        if checkBoxButton.isSelected {
            UserDefaults.standard.set(true, forKey: "dontShowFirstScreenAgain")
        }

        let mainVC = MainTabBarController()
        let onboardingVC = OnboardingScreenVC()

        if UserDefaults.standard.bool(forKey: "hasViewedOnboardingScreen") {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC)
        } else {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(onboardingVC)
        }
    }
}
