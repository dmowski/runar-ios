//
//  AlignmentInfoVC.swift
//  Runar
//
//  Created by Юлия Лопатина on 19.12.20.
//

import UIKit

extension String {
    static let startAlignment = L10n.startAlignment
    static let showAgain = L10n.showAgain
}

class AlignmentInfoVC: UIViewController {
    
    var background = UIImageView()
    var backgroundFire = UIImageView()
    var name = String()
    var nameLabel = UILabel()
    var startButton = CustomButton()
    var escape = UIButton()
    var descriptionTextView = UITextView()
    var showLabel = UILabel()
    var showButton = UIButton()
    var selected: Bool = false
    var stack = UIStackView()
    
    var viewModel: AlignmentInfoVM!
    
    init(viewModel: AlignmentInfoVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundSetup()
        setUpNameLabel()
        setUpStart()
        setUpEscape()
        setUpDescription()
        setUpShowLabel()
        setUpShowButton()
        setUpStack()
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    func backgroundSetup() {
        backgroundFire.image = Assets.Background.mainFire.image
        backgroundFire.translatesAutoresizingMaskIntoConstraints = false
        backgroundFire.contentMode = .scaleAspectFill
        backgroundFire.isUserInteractionEnabled = true
        self.view.addSubview(backgroundFire)
        NSLayoutConstraint.activate([
            backgroundFire.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundFire.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundFire.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundFire.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        background.image = Assets.Background.backgroundDown.image
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .scaleAspectFill
        background.isUserInteractionEnabled = true
        self.view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: backgroundFire.topAnchor),
            background.bottomAnchor.constraint(equalTo: backgroundFire.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor),
        ])
    }
    
    func setUpNameLabel() {
        nameLabel.text = viewModel.name
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 45 : 55
        nameLabel.font = .amaticBold(size: fontSize)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor =  UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        let nameLabelTop: CGFloat = DeviceType.iPhoneSE ? 35 : 57.heightDependent()
        let nameLabelHeight: CGFloat = DeviceType.iPhoneSE ? 75 : 90
        
        background.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: nameLabelTop),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight),
            nameLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        ])
    }
    
    func setUpStart() {
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 6.58 : 8
        startButton.layer.cornerRadius = radiusConstant
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        startButton.layer.borderWidth = borderConstant
        startButton.setTitle(String.startAlignment, for: .normal)
        startButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        startButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        startButton.translatesAutoresizingMaskIntoConstraints = false
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        startButton.titleLabel?.font = .amaticBold(size: fontSize)
        startButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        startButton.setTitleColor(UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1), for: .highlighted)
        
        startButton.addTarget(self, action: #selector(buttomTapped), for: .touchUpInside)
        
        background.addSubview(startButton)
        let widthConstant: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -40.heightDependent()),
            startButton.widthAnchor.constraint(equalToConstant: widthConstant),
            startButton.heightAnchor.constraint(equalToConstant: heightConstant),
            startButton.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        ])
    }
    
    @objc func buttomTapped(_ sender: Any) {
        let viewModel = AlignmentVM(runeDescription: self.viewModel.runeDescription)
        let viewController = AlignmentVC(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setUpEscape() {
        escape.translatesAutoresizingMaskIntoConstraints = false
        let image = Assets.escape.image
        escape.setImage(image, for: .normal)
        background.addSubview(escape)
        escape.addTarget(self, action: #selector(self.escapeOnTap), for: .touchUpInside)
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? 0 : -10
        let escapeWidthAnchor: CGFloat = DeviceType.iPhoneSE ? 40 : 48
        let escapeTop: CGFloat = DeviceType.iPhoneSE ? 20 : 54.heightDependent()
        NSLayoutConstraint.activate([
            escape.topAnchor.constraint(equalTo: background.topAnchor, constant: escapeTop),
            escape.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: trailingConstant),
            escape.widthAnchor.constraint(equalToConstant: escapeWidthAnchor),
            escape.heightAnchor.constraint(equalToConstant: escapeWidthAnchor)
        ])
    }
    
    @objc func escapeOnTap(sender: UIButton!) {
        navigationController?.popViewController(animated: true)
    }
    
    func setUpDescription() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.text = viewModel.runeDescription.description
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.26
        descriptionTextView.attributedText = NSMutableAttributedString(string: descriptionTextView.text!,
                                                                    attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        descriptionTextView.textColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 17 : 20
        descriptionTextView.font = .systemLight(size: fontSize)
        descriptionTextView.textAlignment = .left
        descriptionTextView.sizeToFit()
        descriptionTextView.showsVerticalScrollIndicator = false
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.isEditable = false
        
        background.addSubview(descriptionTextView)
        background.addSubview(stack)
        let leadingAnchor: CGFloat = DeviceType.iPhoneSE ? 24 : 32
        let trailingAnchor: CGFloat = DeviceType.iPhoneSE ? -24 : -32
        let topAnchor: CGFloat = DeviceType.iPhoneSE ? 7 : 31.heightDependent()
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: trailingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: topAnchor.heightDependent()),
            descriptionTextView.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -8)
        ])
    }
    
    func setUpShowButton(){
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.setImage(Assets.unselected.image, for: .normal)
        
        showButton.addTarget(self, action: #selector(select), for: .touchUpInside)
        
        let widthContant: CGFloat = DeviceType.iPhoneSE ? 23.02 : 28
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 23.02 : 28
        NSLayoutConstraint.activate([
            showButton.widthAnchor.constraint(equalToConstant: widthContant),
            showButton.heightAnchor.constraint(equalToConstant: heightConstant),
        ])
    }
    
    func setUpShowLabel() {
        showLabel.text = String.showAgain
        showLabel.translatesAutoresizingMaskIntoConstraints = false
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 14 : 16
        showLabel.font = .systemLight(size: fontSize)
        showLabel.textColor = UIColor(red: 0.659, green: 0.651, blue: 0.639, alpha: 1)
        showLabel.textAlignment = .left
        
        let heightAnchor: CGFloat = DeviceType.iPhoneSE ? 23.02 : 28
        NSLayoutConstraint.activate([
            showLabel.heightAnchor.constraint(equalToConstant: heightAnchor)
        ])
    }
    
    func setUpStack() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        let spacing: CGFloat = DeviceType.iPhoneSE ? 9.86 : 12
        stack.spacing = spacing
        
        stack.addArrangedSubview(showButton)
        stack.addArrangedSubview(showLabel)
        
        let bottomAnchor: CGFloat = DeviceType.iPhoneSE ? -13.15 : -27
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: bottomAnchor)
        ])
    }
    
    @objc func select(sender: UIButton!) {
        if let button = sender {
            if button.isSelected {
                showButton.setImage(Assets.unselected.image, for: .normal)
                button.isSelected = false
                LocalStorage.push(false, forKey: viewModel.name)
            } else {
                showButton.setImage(Assets.selected.image, for: .selected)
                button.isSelected = true
                LocalStorage.push(true, forKey: viewModel.name)
            }
        }
    }
}
