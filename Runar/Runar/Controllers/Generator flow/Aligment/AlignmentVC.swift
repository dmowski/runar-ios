//
//  AlignmentVC.swift
//  Runar
//
//  Created by Oleg Kanatov on 20.01.21.
//

import UIKit

extension String {
    static let interpret = L10n.interpret
    static let drawRune = L10n.drawRune
}

class AlignmentVC: UIViewController {
    
    private let backgroundView = UIImageView()
    let escapeButton = UIButton()
    let nameLabel = UILabel()
    let startButton = CustomButton()
    var runesViewContainer = RunesView()
    let showButton = UIButton()
    let scrollViewAlignment = UIScrollView()
    let contentView = UIView()
    public var viewModel: AlignmentVM!
    let contentInterpretationView = UIView()
    let luckLevelLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let descriptionLabel = UILabel()
    let affirmationLabel = UILabel()
    let cancelButton = CustomButton()
    let dividingLine = UIView()
    var totalLuck: Int = 10
    var affirmation = Affirmation()
    var readyToOpen = false
    var containerTopAnchor : NSLayoutConstraint!
    let invibaleView = UIView()
    let popapLabel = UILabel()
    var scrollViewTop : NSLayoutConstraint!
    let viewBlack = UIView()
    let checkButton = UIButton()
    let checkLabel = UILabel()
    let checkStack = UIStackView()
    
    var isFirstRuneOpen: Bool = false
    
    init(viewModel: AlignmentVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        runesViewContainer.update(with: .init(viewController: self, runesLayout: viewModel.runeLayout, didHighlightAllRunes: { [weak self] runes in
            self?.startButton.setTitle(String.interpret, for: .normal)
            self?.startButton.addTarget(self, action: #selector(self?.buttonTaped), for: .touchUpInside)
            self?.isFirstRuneOpen = true
        }, firstRuneOpened: {
            self.isFirstRuneOpen = true
        }))
        scrollViewAlignment.isScrollEnabled = false
        scrollViewAlignment.showsVerticalScrollIndicator = false
        
        runesViewContainer.setRuneLayout(viewModel.runeLayout)
        navigationController?.tabBarController?.tabBar.isHidden = true
        setUpScrollView()
        backgroundViewSetup()
        setUpEscape()
        setUpStart()
        setUpNameLabel()
        setUpContainerView()
        setUpShowButton()
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
            
            contentView.topAnchor.constraint(equalTo: scrollViewAlignment.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollViewAlignment.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollViewAlignment.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollViewAlignment.heightAnchor)
        ])
    }
    
    // MARK: - Background
    func backgroundViewSetup() {
        backgroundView.image = Assets.Background.backgroundInterpretation.image
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
        
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? 0 : -10
        let widthAnchor: CGFloat = DeviceType.iPhoneSE ? 40 : 48
        let escapeTop: CGFloat = DeviceType.iPhoneSE ? 20 : 54
        
        NSLayoutConstraint.activate([
            escapeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: escapeTop.heightDependent()),
            escapeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConstant),
            escapeButton.widthAnchor.constraint(equalToConstant: widthAnchor),
            escapeButton.heightAnchor.constraint(equalToConstant: widthAnchor)
        ])
    }
    
    @objc func buttonTaped (sender: UIButton!) {
        let runeDescription = viewModel.runeDescription
        let viewModel = ProcessingVM(name: runeDescription.name, title: nil) { [weak self] in
            
            self?.setUpContentAfterAdvertising()
            self?.navigationController?.popViewController(animated: true)
        }
        
        let viewController = ProcessingVC()
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
        self.readyToOpen = true
    }
    
    @objc func escapeOnTap (sender: UIButton!) {
        if isFirstRuneOpen == true {
            let viewController = EscapePopUpVC()
            viewController.setRoot(root: self)
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - NameLabel
    func invisibaleView() {
        invibaleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(invibaleView)
        NSLayoutConstraint.activate([
            invibaleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            invibaleView.heightAnchor.constraint(equalToConstant: 139.heightDependent()),
            invibaleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            invibaleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            invibaleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setUpNameLabel() {
        nameLabel.text = viewModel.name
        
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 45 : 55
        nameLabel.font = .amaticBold(size: fontSize)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = Assets.Colors.textColor.color
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        contentView.addSubview(nameLabel)
        let nameLabelTop: CGFloat = DeviceType.iPhoneSE ? 33 : 57
        let nameLabelHeight: CGFloat = DeviceType.iPhoneSE ? 75 : 90
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: nameLabelTop.heightDependent()),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func popapNameLabel() {
        popapLabel.text = viewModel.name
        
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 45 : 55
        popapLabel.font = .amaticBold(size: fontSize)
        
        popapLabel.translatesAutoresizingMaskIntoConstraints = false
        popapLabel.textColor = Assets.Colors.textColor.color
        popapLabel.textAlignment = .center
        popapLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        view.addSubview(popapLabel)
        let heightAnchor: CGFloat = DeviceType.iPhoneSE ? 65 : 96
        NSLayoutConstraint.activate([
            popapLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 43.heightDependent()),
            popapLabel.heightAnchor.constraint(equalToConstant: heightAnchor),
            popapLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popapLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func viewBlackBackground() {
        viewBlack.backgroundColor = .black
        viewBlack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewBlack)
        NSLayoutConstraint.activate([
            viewBlack.topAnchor.constraint(equalTo: view.topAnchor),
            viewBlack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewBlack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewBlack.bottomAnchor.constraint(equalTo: popapLabel.topAnchor)
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
        startButton.setTitle(String.drawRune, for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        
        startButton.titleLabel?.font = .amaticBold(size: fontSize)
        startButton.addTarget(self, action: #selector(self.openButton), for: .touchUpInside)
        startButton.setTitleColor(Assets.Colors.textColor.color, for: .normal)
        startButton.setTitleColor(UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1), for: .highlighted)
        contentView.addSubview(startButton)
        
        let widthConstant: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40.heightDependent()),
            startButton.widthAnchor.constraint(equalToConstant: widthConstant),
            startButton.heightAnchor.constraint(equalToConstant: heightConstant),
            startButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    @objc func openButton (sender: UIButton!) {
        self.runesViewContainer.openHighlightedButton()
        isFirstRuneOpen = true
    }
    
    // MARK: - ContainerView
    func setUpContainerView() {
        runesViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(runesViewContainer)
        
        NSLayoutConstraint.activate([
            runesViewContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -20.heightDependent()),
            runesViewContainer.bottomAnchor.constraint(equalTo: startButton.topAnchor),
            runesViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            runesViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    // MARK: - ShowButton and label
    func setUpShowButton() {
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.setImage(Assets.learnAboutTheAlignment.image, for: .normal)
        showButton.addTarget(self, action: #selector(self.openDescriptionPopup), for: .touchUpInside)
        contentView.addSubview(showButton)
        
        let leadingAnchor: CGFloat = DeviceType.iPhoneSE ? 0 : 14.heightDependent()
        
        NSLayoutConstraint.activate([
            showButton.leadingAnchor.constraint(equalTo: startButton.trailingAnchor, constant: leadingAnchor),
            showButton.centerYAnchor.constraint(equalTo: startButton.centerYAnchor),
            showButton.widthAnchor.constraint(equalToConstant: 48),
            showButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    // MARK: - Info PopUp
    @objc func openDescriptionPopup (sender: UIButton!) {
        let viewModel = RuneDescriptionPopUpVM(runeDescription: self.viewModel.runeDescription)
        let viewController = RuneDescriptionPopUp()
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true)
    }
    
    func addOneRuneViewController(controller: OneRuneVC) {
        invisibaleView()
        controller.luck = luckLevelLabel.text
        if runesViewContainer.runeLayout != .dayRune && self.children.isEmpty {
            self.readyToOpen = false
            contentInterpretationView.isHidden = true
            self.addChild(controller)
            self.view.addSubview(controller.view)
            controller.didMove(toParent: self)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.removeFromSuperview()
            popapNameLabel()
            viewBlackBackground()
            containerTopAnchor.isActive = false
            containerTopAnchor = runesViewContainer.topAnchor.constraint(equalTo: invibaleView.centerYAnchor)
            containerTopAnchor.isActive = true
            
            scrollViewAlignment.isScrollEnabled = false
            NSLayoutConstraint.activate([
                controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                controller.view.heightAnchor.constraint(equalToConstant: view.frame.height * 2 / 3)
            ])
            controller.closeVC = { [weak self] in
                let topAnchor: CGFloat = DeviceType.iPhoneSE ? 117 : 162
                self?.contentInterpretationView.isHidden = false
                self?.containerTopAnchor!.constant = topAnchor
                self?.containerTopAnchor.isActive = false
                self?.containerTopAnchor = self?.runesViewContainer.topAnchor.constraint(equalTo: (self?.contentView.topAnchor)!, constant: topAnchor)
                self?.containerTopAnchor.isActive = true
                self?.nameLabel.backgroundColor = .clear
                self?.popapLabel.removeFromSuperview()
                self?.setUpNameLabel()
                self?.viewBlack.removeFromSuperview()
                self?.scrollViewAlignment.isScrollEnabled = true
                self?.invibaleView.removeFromSuperview()
                self?.readyToOpen = true
                self?.scrollViewAlignment.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            
            controller.changeContentOffset = { [self]frame in
                var heightConstant: CGFloat = 0
                switch (runesViewContainer.runeLayout, DeviceType.iPhoneSE) {
                case (.dayRune, false):
                    break
                case (.twoRunes, false):
                    heightConstant = 230.heightDependent()
                case (.norns, false):
                    heightConstant = 300.heightDependent()
                case (.shortPrediction, false):
                    heightConstant = 250.heightDependent()
                case (.thorsHummer, false):
                    heightConstant = 60.heightDependent()
                case (.cross, false):
                    heightConstant = 230.heightDependent()
                case (.elementsCross, false):
                    heightConstant = 100.heightDependent()
                case (.keltsCross, false):
                    heightConstant = 120.heightDependent()
                case (.dayRune, true):
                    break
                case (.twoRunes, true):
                    heightConstant = 200
                case (.norns, true):
                    heightConstant = 235
                case (.shortPrediction, true):
                    heightConstant = 150
                case (.thorsHummer, true):
                    heightConstant = 60
                case (.cross, true):
                    heightConstant = 150
                case (.elementsCross, true):
                    heightConstant = 50
                case (.keltsCross, true):
                    heightConstant = 70
                }
                scrollViewAlignment.contentOffset.y = frame.origin.y - heightConstant
            }
        } else {
            self.readyToOpen = false
        }
    }
}
