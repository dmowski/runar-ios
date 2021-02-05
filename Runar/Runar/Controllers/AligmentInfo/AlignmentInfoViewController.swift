//
//  AlignmentInfoViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 19.12.20.
//

import UIKit

class AlignmentInfoViewController: UIViewController {
    
    private let nameFontMultiplier = 55/785
    var background = UIImageView()
    var backgroundFire = UIImageView()
    var name = String()
    var nameLabel = UILabel()
    var startButton = UIButton()
    var escape = UIButton()
    var descriptionLabel = UILabel()
    var showLabel = UILabel()
    var showButton = UIButton()
    var selected: Bool = false
    var stack = UIStackView()
    
    var viewModel: AlignmentInfoViewModel!
    
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
    }
    
    func backgroundSetup() {
        backgroundFire.image = UIImage(named: "main_fire")
        backgroundFire.translatesAutoresizingMaskIntoConstraints = false
        backgroundFire.contentMode = .scaleAspectFill
        backgroundFire.isUserInteractionEnabled = true
        self.view.addSubview(backgroundFire)
        NSLayoutConstraint.activate([
            backgroundFire.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundFire.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundFire.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundFire.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        background.image = UIImage(named: "backgroundDown")
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
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 45 : 55
        nameLabel.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor =  UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        
        background.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 25),
            nameLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 65),
            nameLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        ])
    }
    
    func setUpStart() {
        startButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        startButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 6.58 : 8
        startButton.layer.cornerRadius = radiusConstant
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        startButton.layer.borderWidth = borderConstant
        startButton.setTitle("Начать расклад", for: .normal)
        
        startButton.addTarget(self, action: #selector(buttomTapped), for: .touchUpInside)
        
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
  
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        startButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        background.addSubview(startButton)
        
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? -55 : -65
        let topConstant: CGFloat = DeviceType.iPhoneSE ? -46 : -54
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 55 : 80
        let widthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: bottomConstant),
            startButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: topConstant),
                startButton.leadingAnchor.constraint(lessThanOrEqualTo: background.leadingAnchor, constant: leadingConstant),
            startButton.widthAnchor.constraint(equalToConstant: widthConsatnt),
            startButton.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        ])
    }
    
    @objc func buttomTapped(_ sender: Any) {
        let viewModel = AlignmentViewModel(runeDescription: self.viewModel.runeDescription)
        let viewController = AlignmentViewController()
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setUpEscape() {
        escape.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "escape")
        escape.setImage(image, for: .normal)
        background.addSubview(escape)
        escape.addTarget(self, action: #selector(self.escapeOnTap), for: .touchUpInside)
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -4 : -8
        let widthAnchor: CGFloat = DeviceType.iPhoneSE ? 40 : 48

        NSLayoutConstraint.activate([
            escape.topAnchor.constraint(equalTo: background.topAnchor),
            escape.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: trailingConstant),
            escape.widthAnchor.constraint(equalToConstant: widthAnchor),
            escape.bottomAnchor.constraint(equalTo: escape.topAnchor, constant: widthAnchor)

        ])
    }
    
    
    @objc func escapeOnTap (sender: UIButton!) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUpDescription() {
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.text = viewModel.runeDescription.description
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.26
        descriptionLabel.attributedText = NSMutableAttributedString(string: descriptionLabel.text!, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        descriptionLabel.textColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 17 : 20
        descriptionLabel.font = FontFamily.SFProDisplay.light.font(size: fontConstant)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.sizeToFit()
        background.addSubview(descriptionLabel)
        
            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 32),
                descriptionLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -32),
                descriptionLabel.topAnchor.constraint(equalTo: escape.bottomAnchor, constant: 60),
                descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: startButton.bottomAnchor, constant: -100),
            ])
        
    }
    
    func setUpShowButton(){
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.setImage(UIImage(named: "unselected"), for: .normal)
        background.addSubview(showButton)
        showButton.addTarget(self, action: #selector(select), for: .touchUpInside)
        
        let widthContant: CGFloat = DeviceType.iPhoneSE ? 16.44 : 20
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 16.44 : 20
        
            NSLayoutConstraint.activate([
                
                showButton.widthAnchor.constraint(equalToConstant: widthContant),
                showButton.heightAnchor.constraint(equalToConstant: heightConstant),
            ])

    }
    
    func setUpShowLabel() {
        showLabel.text = "Больше не показывать"
        showLabel.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 14 : 16
        descriptionLabel.font = FontFamily.Roboto.light.font(size: fontConstant)
        showLabel.textColor = UIColor(red: 0.659, green: 0.651, blue: 0.639, alpha: 1)
        showLabel.textAlignment = .left
        background.addSubview(showLabel)
        
        NSLayoutConstraint.activate([
            
            showLabel.widthAnchor.constraint(equalToConstant: 223),
            showLabel.heightAnchor.constraint(equalToConstant: 28)
            
        ])
    }
    
    func setUpStack() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 12
        
        background.addSubview(stack)
        stack.addArrangedSubview(showButton)
        stack.addArrangedSubview(showLabel)
        
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 55 : 80
      
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(lessThanOrEqualTo: background.leadingAnchor, constant: leadingConstant),
            stack.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -18)
            
        ])
        
    }
    
    @objc func select(sender: UIButton!) {
        if let button = sender {
                   if button.isSelected {
                    showButton.setImage(UIImage(named: "unselected"), for: .normal)
                       button.isSelected = false
                    UserDefaults.standard.set(false, forKey: viewModel.name)
                      } else {
                        showButton.setImage(UIImage(named: "selected"), for: .selected)
                       button.isSelected = true
                        UserDefaults.standard.set(true, forKey: viewModel.name)
                      }
                  }
    }
}
