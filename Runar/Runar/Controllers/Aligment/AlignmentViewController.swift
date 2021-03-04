//
//  AlignmentViewController.swift
//  Runar
//
//  Created by Oleg Kanatov on 20.01.21.
//

import UIKit

class AlignmentViewController: UIViewController {
    
    //-------------------------------------------------
    // MARK: - Variables
    //-------------------------------------------------
    
    private let backgroundView = UIImageView()
    private let escapeButton = UIButton()
    private let nameLabel = UILabel()
    private let startButton = UIButton()
    var runesViewContainer = RunesView()
    private let showButton = UIButton()
    private let showLabel = UILabel()
    var stack = UIStackView()
    private let scrollViewAlignment = UIScrollView()
    private let contentView = UIView()
    public var viewModel: AlignmentViewModel!
    private let contentInterpretationView = UIView()
    private let luckLevelLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let affirmationLabel = UILabel()
    private let cancelButton = UIButton()
    private let dividingLine = UIView()
    private var text = String()
    private var totalLuck: Int = 10
    private var affirmation = Affirmation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runesViewContainer.update(with: .init(didHighlightAllRunes: { [weak self] runes in
            self?.startButton.setTitle("Толковать", for: .normal)
            self?.startButton.addTarget(self, action: #selector(self?.buttonTaped), for: .touchUpInside)
        }))
        
        scrollViewAlignment.isScrollEnabled = false
        scrollViewAlignment.showsVerticalScrollIndicator = false
        
        runesViewContainer.setRuneLayout(viewModel.runeLayout)
        
        setUpScrollView()
        
        backgroundViewSetup()
        setUpEscape()
        setUpNameLabel()
        setUpStart()
        setUpContainerView()
        
        setUpShowButton()
        setUpShowLabel()
        setUpStack()
    }
    // MARK: -ScrollView
    
    func setUpScrollView() {
        scrollViewAlignment.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollViewAlignment)
        scrollViewAlignment.addSubview(contentView)
        contentView.addSubview(backgroundView)
        scrollViewAlignment.contentInsetAdjustmentBehavior = .never
        scrollViewAlignment.bounces = false
        
        NSLayoutConstraint.activate([
            scrollViewAlignment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollViewAlignment.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollViewAlignment.topAnchor.constraint(equalTo: view.topAnchor),
            scrollViewAlignment.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollViewAlignment.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: scrollViewAlignment.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollViewAlignment.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollViewAlignment.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollViewAlignment.heightAnchor)
        ])
    }
    
    // MARK: - Background
    
    func backgroundViewSetup() {
        backgroundView.image = Assets.mainFire.image
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: view.frame.height),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    // MARK: - EscapeButton
    
    func setUpEscape() {
        escapeButton.translatesAutoresizingMaskIntoConstraints = false
        let image = Assets.escape.image
        escapeButton.setImage(image, for: .normal)
        contentView.addSubview(escapeButton)
        escapeButton.addTarget(self, action: #selector(self.escapeOnTap), for: .touchUpInside)
        
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -4 : -8
        let widthAnchor: CGFloat = DeviceType.iPhoneSE ? 40 : 48
        
        NSLayoutConstraint.activate([
            escapeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50.heightDependent()),
            escapeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConstant),
            escapeButton.widthAnchor.constraint(equalToConstant: widthAnchor),
            escapeButton.heightAnchor.constraint(equalToConstant: widthAnchor)
            
        ])
    }
    
    @objc func buttonTaped (sender: UIButton!) {
        let runeDescription = viewModel.runeDescription
        let viewModel = ProcessingViewModel(runeDescription: runeDescription) { [weak self] in
            
            self?.setUpContentAfterAdvertising()
            self?.navigationController?.popViewController(animated: true)
        }
        
        let viewController = ProcessingViewController()
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func escapeOnTap (sender: UIButton!) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - NameLabel
    
    func setUpNameLabel() {
        nameLabel.text = viewModel.name
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 45 : 55
        nameLabel.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = Assets.Colors.textColor.color
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 77.heightDependent()),
            nameLabel.heightAnchor.constraint(equalToConstant: 65.heightDependent()),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    // MARK: - StartButton
    
    func setUpStart() {
        startButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        startButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 6.58 : 8
        startButton.layer.cornerRadius = radiusConstant
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        startButton.layer.borderWidth = borderConstant
        startButton.setTitle("Вытянуть руну", for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        startButton.addTarget(self, action: #selector(self.openButton), for: .touchUpInside)
        startButton.setTitleColor(Assets.Colors.textColor.color, for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        contentView.addSubview(startButton)
        
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? 373 : 631
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        let widthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: bottomConstant),
            startButton.heightAnchor.constraint(equalToConstant: heightConstant),
            startButton.widthAnchor.constraint(equalToConstant: widthConsatnt),
            startButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -82.heightDependent())
        ])
    }
    
    
    @objc func openButton (sender: UIButton!) {
        self.runesViewContainer.openHighlightedButton()
    }
    
    // MARK: - ContainerView
    
    func setUpContainerView() {
        runesViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(runesViewContainer)
        
        NSLayoutConstraint.activate([
            runesViewContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            runesViewContainer.bottomAnchor.constraint(equalTo: startButton.topAnchor),
            runesViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            runesViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    // MARK: - ShowButton and label
    func setUpShowButton(){
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.layer.borderColor = Assets.Colors.textColor.color.cgColor
        
        showButton.layer.borderWidth = 1
        showButton.layer.cornerRadius = 12
        showButton.setTitle("i", for: .normal)
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 14 : 16
        showButton.titleLabel?.font = FontFamily.SFProDisplay.light.font(size: fontConstant)
        
        let constant: CGFloat = DeviceType.iPhoneSE ? 21 : 24
        NSLayoutConstraint.activate([
            showButton.widthAnchor.constraint(equalToConstant: constant),
            showButton.heightAnchor.constraint(equalToConstant: constant),
        ])
    }
    
    func setUpShowLabel() {
        showLabel.text = "Узнать о раскладе"
        showLabel.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 14 : 16
        showLabel.font = FontFamily.SFProDisplay.light.font(size: fontConstant)
        showLabel.textColor = Assets.Colors.textColor.color
        showLabel.textAlignment = .left
        let widthConstant : CGFloat = DeviceType.iPhoneSE ? 115 : 130
        let heightConstant : CGFloat = DeviceType.iPhoneSE ? 36 : 56
        
        NSLayoutConstraint.activate([
            showLabel.widthAnchor.constraint(equalToConstant: widthConstant),
            showLabel.heightAnchor.constraint(equalToConstant: heightConstant)
        ])
    }
    
    func setUpStack() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 12
        stack.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(openDescriptionPopup))
        stack.addGestureRecognizer(tap)
        
        contentView.addSubview(stack)
        stack.addArrangedSubview(showButton)
        stack.addArrangedSubview(showLabel)
        
        let bottomomConstant : CGFloat = DeviceType.iPhoneSE ?  6 : 16
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: bottomomConstant)
            
        ])
    }
    
    // MARK: -PopUp
    
    @objc func openDescriptionPopup (sender: UIButton!) {
        let viewModel = RuneDescriptionPopUpViewModel(runeDescription: self.viewModel.runeDescription)
        let viewController = RuneDescriptionPopUp()
        viewController.viewModel = viewModel
        // viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
        
    }
    
    
    //-------------------------------------------------
    // MARK: - After advertising
    //-------------------------------------------------
    
    func setUpContentAfterAdvertising() {
        scrollViewAlignment.isScrollEnabled = true
        
        stack.removeFromSuperview()
        startButton.removeFromSuperview()
        escapeButton.removeFromSuperview()
        
        removeConstant()
        setUpContentInterpretationView()
        setUpLuckLevelLabel()
        setUpDividingLine()
        setUpDescriptionLabel()
        setUpAffirmationLabel()
        setUpCancel()
    }
    
    func removeConstant() {
        runesViewContainer.removeFromSuperview()
        runesViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(runesViewContainer)
        
        NSLayoutConstraint.activate([
            runesViewContainer.centerXAnchor.constraint(equalTo: scrollViewAlignment.centerXAnchor),
            runesViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            runesViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            runesViewContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 35.heightDependent()),
        ])
    }
    
    func setUpContentInterpretationView() {
        let backgroundImage: UIImage = {
            let image = Assets.interpretationBackground.image
            return image
        }()
        
        contentInterpretationView.backgroundColor = UIColor(patternImage: backgroundImage)
        contentInterpretationView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentInterpretationView)
        
        NSLayoutConstraint.activate([
            contentInterpretationView.topAnchor.constraint(equalTo: runesViewContainer.bottomAnchor),
            contentInterpretationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentInterpretationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentInterpretationView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
        ])
    }
    
    // MARK: - Luck Label
    
    func setUpLuckLevelLabel() {
        switch runesViewContainer.runeLayout {
        case .dayRune:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            totalLuck = runesViewContainer.runesSet[0].luck
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .twoRunes:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[0].luck
            let luck2 = runesViewContainer.runesSet[1].luck
            totalLuck = (luck1 + luck2)/2
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .norns:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            totalLuck = runesViewContainer.runesSet[2].luck
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .shortPrediction:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[3].luck
            totalLuck = (luck1 + luck2)/2
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .thorsHummer:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[1].luck
            let luck2 = runesViewContainer.runesSet[2].luck
            let luck3 = runesViewContainer.runesSet[3].luck
            totalLuck = (luck1 + luck2 + luck3)/3
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .cross:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[3].luck
            let luck3 = runesViewContainer.runesSet[4].luck
            totalLuck = (luck1 + luck2 + luck3)/3
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .elementsCross:
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[4].luck
            let luck3 = runesViewContainer.runesSet[5].luck
            totalLuck = (luck1 + luck2 + luck3)/3
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .keltsCross:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[4].luck
            let luck3 = runesViewContainer.runesSet[5].luck
            let luck4 = runesViewContainer.runesSet[5].luck
            totalLuck = (luck1 + luck2 + luck3 + luck4)/4
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        }
        
        luckLevelLabel.font = FontFamily.SFProDisplay.light.font(size: 20.heightDependent())
        luckLevelLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        luckLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(luckLevelLabel)
        NSLayoutConstraint.activate([
            luckLevelLabel.topAnchor.constraint(equalTo: contentInterpretationView.topAnchor, constant: 76.heightDependent()),
            luckLevelLabel.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24.heightDependent()),
            luckLevelLabel.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor,constant: -24.heightDependent()),
        ])
    }
    
    func setUpDividingLine() {
        dividingLine.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.3)
        dividingLine.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(dividingLine)
        
        NSLayoutConstraint.activate([
            dividingLine.topAnchor.constraint(equalTo: luckLevelLabel.bottomAnchor, constant: 27.heightDependent()),
            dividingLine.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24.heightDependent()),
            dividingLine.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor, constant: -24.heightDependent()),
            dividingLine.heightAnchor.constraint(equalToConstant: 1.heightDependent())
        ])
        
    }
    
    // MARK: - DescriptionLabel
    
    func setUpDescriptionLabel() {
        switch runesViewContainer.runeLayout {
        case .dayRune:
            descriptionLabel.text = runesViewContainer.runesSet[0].description
        case .twoRunes:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let description = firstRune.cross(runeType: secondRune)
            descriptionLabel.text = L10n.InterpretationForTwoRunes.text(description)
        case .norns:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            descriptionLabel.text = L10n.InterpretationForNorns.text(firstRune.value, secondRune.value, thirdRune.value)
        case .shortPrediction:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            descriptionLabel.text = L10n.InterpretationForShortPrediction.text(firstRune, secondRune, thirdRune, fourthRune)
        case .thorsHummer:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let fourthRune = runesViewContainer.runesSet[3]
            descriptionLabel.text = L10n.InterpretationForThorsHummer.text(firstRune, secondRune, fourthRune)
        case .cross:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            let fifthRune = runesViewContainer.runesSet[4]
            descriptionLabel.text = L10n.InterpretationForСross.text(firstRune, secondRune, thirdRune, fifthRune, fourthRune)
        case .elementsCross:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            let fifthRune = runesViewContainer.runesSet[4]
            let sixthRune = runesViewContainer.runesSet[5]
            descriptionLabel.text = L10n.InterpretationElementsCross.text(secondRune, firstRune, fourthRune, thirdRune, fifthRune, sixthRune)
        case .keltsCross:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            let fifthRune = runesViewContainer.runesSet[4]
            let sixthRune = runesViewContainer.runesSet[5]
            let seventhRune = runesViewContainer.runesSet[6]
            descriptionLabel.text = L10n.InterpretationKeltsCross.text(firstRune, secondRune, thirdRune, fourthRune, fifthRune, sixthRune, seventhRune)
            
        }
        
        descriptionLabel.font = FontFamily.Roboto.thin.font(size: 19.heightDependent())
        descriptionLabel.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dividingLine.bottomAnchor, constant: 32.heightDependent()),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24.heightDependent()),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor, constant: -24.heightDependent()),
        ])
    }
    
    // MARK: - AffirmationLabel
    
    func setUpAffirmationLabel() {
        if totalLuck>39 && totalLuck<=50 {
            affirmationLabel.text = affirmation.fourtyPercent.randomElement()
        } else if totalLuck>29 && totalLuck<=39 {
            affirmationLabel.text = affirmation.thirtyPercent.randomElement()
        } else if totalLuck>19 && totalLuck<=29 {
            affirmationLabel.text = affirmation.twentyPercent.randomElement()
        } else if totalLuck>=10 && totalLuck<=19 {
            affirmationLabel.text = affirmation.tenPercent.randomElement()
        } else {
            affirmationLabel.isHidden = true
        }
        
        affirmationLabel.font = FontFamily.SFProDisplay.light.font(size: 20.heightDependent())
        affirmationLabel.textColor = Assets.Colors.Touch.text.color
        affirmationLabel.numberOfLines = 0
        affirmationLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.22
        affirmationLabel.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
        affirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(affirmationLabel)
        NSLayoutConstraint.activate([
            affirmationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30.heightDependent()),
            affirmationLabel.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24.heightDependent()),
            affirmationLabel.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor, constant: -24.heightDependent()),
        ])
    }
    
    // MARK: - CompleteButton
    
    func setUpCancel() {
        cancelButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        cancelButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 6.58 : 8
        cancelButton.layer.cornerRadius = radiusConstant
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        cancelButton.layer.borderWidth = borderConstant
        cancelButton.setTitle("Завершить", for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        cancelButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        cancelButton.addTarget(self, action: #selector(self.escapeOnTap), for: .touchUpInside)
        cancelButton.setTitleColor(Assets.Colors.textColor.color, for: .normal)
        cancelButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        contentInterpretationView.addSubview(cancelButton)
        
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        let widthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: heightConstant),
            cancelButton.widthAnchor.constraint(equalToConstant: widthConsatnt),
            cancelButton.centerXAnchor.constraint(equalTo: contentInterpretationView.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: affirmationLabel.bottomAnchor, constant: 115.heightDependent()),
            cancelButton.bottomAnchor.constraint(equalTo: contentInterpretationView.bottomAnchor, constant: -75)
        ])
    }
}


