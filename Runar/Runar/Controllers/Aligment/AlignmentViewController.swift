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
    let escapeButton = UIButton()
    let nameLabel = UILabel()
    let startButton = UIButton()
    var runesViewContainer = RunesView()
    private let showButton = UIButton()
    private let showLabel = UILabel()
    var stack = UIStackView()
    let scrollViewAlignment = UIScrollView()
    let contentView = UIView()
    public var viewModel: AlignmentViewModel!
    let contentInterpretationView = UIView()
    let luckLevelLabel = UILabel()
    let descriptionLabel = UILabel()
    let affirmationLabel = UILabel()
    let cancelButton = UIButton()
    let dividingLine = UIView()
    var totalLuck: Int = 10
    var affirmation = Affirmation()
    var readyToOpen = false
    var containerTopAnchor : NSLayoutConstraint!
    let invibaleView = UIView()
    let popapLabel = UILabel()
    var scrollViewTop : NSLayoutConstraint!
    let viewBlack = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runesViewContainer.update(with: .init(viewController: self, runesLayout: viewModel.runeLayout, didHighlightAllRunes: { [weak self] runes in
            self?.startButton.setTitle("Толковать", for: .normal)
            self?.startButton.addTarget(self, action: #selector(self?.buttonTaped), for: .touchUpInside)
        }))
        
        scrollViewAlignment.isScrollEnabled = false
        scrollViewAlignment.showsVerticalScrollIndicator = false
        
        runesViewContainer.setRuneLayout(viewModel.runeLayout)
        
        setUpScrollView()
        
        backgroundViewSetup()
        setUpEscape()
        invisibaleView()
        setUpStart()
        setUpContainerView()
        setUpNameLabel()
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
        scrollViewTop = scrollViewAlignment.topAnchor.constraint(equalTo: view.topAnchor)
        scrollViewTop.isActive = true
        NSLayoutConstraint.activate([
            scrollViewAlignment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollViewAlignment.widthAnchor.constraint(equalTo: view.widthAnchor),
//            scrollViewAlignment.topAnchor.constraint(equalTo: view.topAnchor),
            scrollViewAlignment.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
        self.readyToOpen = true
    }
    
    @objc func escapeOnTap (sender: UIButton!) {
        navigationController?.popToRootViewController(animated: true)
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
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 45 : 55
        nameLabel.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = Assets.Colors.textColor.color
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 43.heightDependent()),
            nameLabel.heightAnchor.constraint(equalToConstant: 96.heightDependent()),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func popapNameLabel() {
        popapLabel.text = viewModel.name
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 45 : 55
        popapLabel.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        
        popapLabel.translatesAutoresizingMaskIntoConstraints = false
        popapLabel.textColor = Assets.Colors.textColor.color
        popapLabel.textAlignment = .center
        popapLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        popapLabel.backgroundColor = UIColor(patternImage: Assets.nameLabelGradient.image)
        view.addSubview(popapLabel)
        
        NSLayoutConstraint.activate([
            popapLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 43.heightDependent()),
            popapLabel.heightAnchor.constraint(equalToConstant: 96.heightDependent()),
            popapLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popapLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popapLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
        startButton.setTitle("Вытянуть руну", for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        startButton.addTarget(self, action: #selector(self.openButton), for: .touchUpInside)
        startButton.setTitleColor(Assets.Colors.textColor.color, for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        contentView.addSubview(startButton)
        
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? 373 : 785
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        let widthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: bottomConstant.heightDependent()),
            startButton.heightAnchor.constraint(equalToConstant: heightConstant.heightDependent()),
            startButton.widthAnchor.constraint(equalToConstant: widthConsatnt.heightDependent()),
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
            runesViewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 162.heightDependent()),
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
    
    // MARK: -Info PopUp
    
    @objc func openDescriptionPopup (sender: UIButton!) {
            let viewModel = RuneDescriptionPopUpViewModel(runeDescription: self.viewModel.runeDescription)
            let viewController = RuneDescriptionPopUp()
            viewController.viewModel = viewModel
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: true)
        }

    

//-------------------------------------------------
// MARK: -
//-------------------------------------------------

func addOneRuneViewController(controller: OneRuneViewController) {
    if runesViewContainer.runeLayout != .dayRune {
    contentInterpretationView.isHidden = true
    self.addChild(controller)
    self.view.addSubview(controller.view)
    controller.didMove(toParent: controller)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.removeFromSuperview()
    popapNameLabel()
    viewBlackBackground()
    containerTopAnchor.isActive = false
    containerTopAnchor = runesViewContainer.topAnchor.constraint(equalTo: invibaleView.centerYAnchor)
    containerTopAnchor.isActive = true
    
    
//    scrollViewTop.isActive = false
//    scrollViewTop = scrollViewAlignment.topAnchor.constraint(equalTo: invibaleView.topAnchor)
//    scrollViewTop.isActive = true
    NSLayoutConstraint.activate([
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: view.frame.height * 2 / 3)
    ])
    controller.didMove(toParent: self)
    controller.closeVC = { [weak self] in
        self?.contentInterpretationView.isHidden = false
        self?.containerTopAnchor!.constant = 162.heightDependent()
        self?.containerTopAnchor.isActive = false
        self?.containerTopAnchor = self?.runesViewContainer.topAnchor.constraint(equalTo: (self?.contentView.topAnchor)!, constant: 162.heightDependent())
        self?.containerTopAnchor.isActive = true
        self?.nameLabel.backgroundColor = .clear
        self?.popapLabel.removeFromSuperview()
        self?.setUpNameLabel()
//        self?.scrollViewTop.isActive = false
//        self?.scrollViewTop = self?.scrollViewAlignment.topAnchor.constraint(equalTo: (self?.view.topAnchor)!)
//        self?.scrollViewTop.isActive = true
        self?.viewBlack.removeFromSuperview()
    }
    
    controller.changeContentOffset = { [self]frame in
        var heightConstant: CGFloat = 0
        switch (runesViewContainer.runeLayout, DeviceType.iPhoneSE) {
        case (.dayRune, false):
            break
        case (.twoRunes, false):
            heightConstant = 220.heightDependent()
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
            heightConstant = 40
        case (.norns, true):
            heightConstant = 100
        case (.shortPrediction, true):
            heightConstant = 50
        case (.thorsHummer, true):
            heightConstant = 60
        case (.cross, true):
            heightConstant = 45
        case (.elementsCross, true):
            heightConstant = 0
        case (.keltsCross, true):
            heightConstant = 0
        }
        scrollViewAlignment.contentOffset.y = frame.origin.y - heightConstant

    }
    }
}

}
