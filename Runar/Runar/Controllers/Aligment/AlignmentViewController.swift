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
    private let labelOne = UILabel()
    private let labelTwo = UILabel()
    private let labelThree = UILabel()
    private let cancelButton = UIButton()
    
    //-------------------------------------------------
    // MARK: - Methods
    //-------------------------------------------------
    
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
    
    func setUpScrollView() {
        scrollViewAlignment.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollViewAlignment)
        scrollViewAlignment.addSubview(contentView)
        contentView.addSubview(backgroundView)
        scrollViewAlignment.contentInsetAdjustmentBehavior = .never
        
        
        NSLayoutConstraint.activate([
            scrollViewAlignment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollViewAlignment.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollViewAlignment.topAnchor.constraint(equalTo: view.topAnchor),
            scrollViewAlignment.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollViewAlignment.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollViewAlignment.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollViewAlignment.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollViewAlignment.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollViewAlignment.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollViewAlignment.heightAnchor)
        ])
    }
    
    func backgroundViewSetup() {
        backgroundView.image = Assets.mainFire.image
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: view.frame.height),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setUpEscape() {
        escapeButton.translatesAutoresizingMaskIntoConstraints = false
        let image = Assets.escape.image
        escapeButton.setImage(image, for: .normal)
        contentView.addSubview(escapeButton)
        escapeButton.addTarget(self, action: #selector(self.escapeOnTap), for: .touchUpInside)
        
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -4 : -8
        let widthAnchor: CGFloat = DeviceType.iPhoneSE ? 40 : 48
        
        NSLayoutConstraint.activate([
            escapeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            escapeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConstant),
            escapeButton.widthAnchor.constraint(equalToConstant: widthAnchor),
            escapeButton.heightAnchor.constraint(equalToConstant: widthAnchor)
            
        ])
    }
    
    @objc func buttonTaped (sender: UIButton!) {
        let runeDescription = viewModel.runeDescription
        let viewModel = ProcessingViewModel(runeDescription: runeDescription) { [weak self] in
            guard let startButton = self?.startButton else { return }
            guard let stack = self?.stack else { return }
            guard let scrollViewAlignment = self?.scrollViewAlignment else { return }
            scrollViewAlignment.isScrollEnabled = true
            
            self?.setUpContentInterpretationView()
            self?.setUpLabelOne()
            self?.setUpLabelTwo()
            self?.setUpLabelThree()
            self?.setUpCancel()
            stack.removeFromSuperview()
            startButton.removeFromSuperview()
            
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
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 77),
            nameLabel.heightAnchor.constraint(equalToConstant: 65),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
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
            startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -82)
        ])
    }
    
    
    @objc func openButton (sender: UIButton!) {
        self.runesViewContainer.openHighlightedButton()
    }
    
    func setUpContainerView() {
        runesViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(runesViewContainer)
        
        NSLayoutConstraint.activate([
            runesViewContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            runesViewContainer.heightAnchor.constraint(equalToConstant: 631),
            runesViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            runesViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
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
            contentInterpretationView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor),
        ])
    }
    
    func setUpLabelOne() {
        labelOne.text = "Прими себя со всеми своими недостатками и смотри только в будущее"
        labelOne.font = FontFamily.SFProDisplay.light.font(size: 20)
        labelOne.textColor = .white
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(labelOne)
        NSLayoutConstraint.activate([
            labelOne.topAnchor.constraint(equalTo: contentInterpretationView.topAnchor),
        ])
    }
    
    func setUpLabelTwo() {
        labelTwo.text = "Благоприятность – 45 %"
        labelTwo.font = FontFamily.SFProDisplay.light.font(size: 20)
        labelTwo.textColor = .white
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(labelTwo)
        NSLayoutConstraint.activate([
            labelTwo.topAnchor.constraint(equalTo: labelOne.bottomAnchor, constant: 50),
        ])
    }
    
    func setUpLabelThree() {
        labelThree.text = "В настоящее время с Вами происходит: Достижение цели, удача, что является следствием вашего прошлого Перемена к лучшему. Чтобы достичь в будущем Окончание Черной полосы в жизни, вам необходимо обратить внимание на непреодолимое обстоятельство. Возможно, причиной ваших трудностей является Эмоциональное переживание. Лучшее, чего Вы можете ожидать - это Бессилие. В результате, вас ждет Неприятное затруднение."
        labelThree.font = FontFamily.SFProDisplay.light.font(size: 20)
        labelThree.textColor = .white
        labelThree.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(labelThree)
        NSLayoutConstraint.activate([
            labelThree.topAnchor.constraint(equalTo: labelTwo.bottomAnchor, constant: 500),
        ])
    }
    
    
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
        cancelButton.addTarget(self, action: #selector(self.openButton), for: .touchUpInside)
        cancelButton.setTitleColor(Assets.Colors.textColor.color, for: .normal)
        cancelButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        contentInterpretationView.addSubview(cancelButton)
        
//        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? 373 : 631
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        let widthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: heightConstant),
            cancelButton.widthAnchor.constraint(equalToConstant: widthConsatnt),
            cancelButton.centerXAnchor.constraint(equalTo: contentInterpretationView.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: labelThree.bottomAnchor, constant: 50),
            cancelButton.bottomAnchor.constraint(equalTo: contentInterpretationView.bottomAnchor)
        ])
    }
}


