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
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
        nameLabel.font = UIFont(name: "AmaticSC-Bold", size: 45)
        } else {
            nameLabel.font = UIFont(name: "AmaticSC-Bold", size: 55)
        }
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
        startButton.layer.cornerRadius = 8
        startButton.layer.borderWidth = 1
        startButton.setTitle("Начать расклад", for: .normal)
        
        startButton.addTarget(self, action: #selector(buttomTapped), for: .touchUpInside)
        
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            startButton.titleLabel?.font = UIFont(name: "AmaticSC-Bold", size: 24)
        } else {
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 30)
        }
        startButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        background.addSubview(startButton)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            NSLayoutConstraint.activate([
                startButton.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -55),
                startButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: -46),
                    startButton.leadingAnchor.constraint(lessThanOrEqualTo: background.leadingAnchor, constant: 55),
                startButton.widthAnchor.constraint(equalToConstant: 210),
                startButton.centerXAnchor.constraint(equalTo: background.centerXAnchor)
            ])
        } else {
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -65),
            startButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: -54),
                startButton.leadingAnchor.constraint(lessThanOrEqualTo: background.leadingAnchor, constant: 80),
            startButton.widthAnchor.constraint(equalToConstant: 255),
            startButton.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        ])
        }
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
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            NSLayoutConstraint.activate([
                escape.topAnchor.constraint(equalTo: background.topAnchor),
                escape.trailingAnchor.constraint(equalTo: background.trailingAnchor),
                escape.widthAnchor.constraint(equalToConstant: 40),
                escape.bottomAnchor.constraint(equalTo: escape.topAnchor, constant: 40)
            ])
        } else {
        NSLayoutConstraint.activate([
            escape.topAnchor.constraint(equalTo: background.topAnchor),
            escape.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            escape.widthAnchor.constraint(equalToConstant: 48),
            escape.bottomAnchor.constraint(equalTo: escape.topAnchor, constant: 48)
        ])
        }
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
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            descriptionLabel.font = UIFont(name: "SFProDisplay-Light", size: 17)
        } else {
        descriptionLabel.font = UIFont(name: "SFProDisplay-Light", size: 20)
        }
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.sizeToFit()
        background.addSubview(descriptionLabel)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -24),
            descriptionLabel.topAnchor.constraint(equalTo: escape.bottomAnchor, constant: 60),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: startButton.bottomAnchor, constant: -100),
        ])
        } else {
            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 32),
                descriptionLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -32),
                descriptionLabel.topAnchor.constraint(equalTo: escape.bottomAnchor, constant: 60),
                descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: startButton.bottomAnchor, constant: -100),
            ])
        }
    }
    

    
    func setUpShowButton(){
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.setImage(UIImage(named: "unselected"), for: .normal)
        background.addSubview(showButton)
        showButton.addTarget(self, action: #selector(select), for: .touchUpInside)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            NSLayoutConstraint.activate([
                
                showButton.widthAnchor.constraint(equalToConstant: 16.44),
                showButton.heightAnchor.constraint(equalToConstant: 16.44),
            ])
        } else {
            NSLayoutConstraint.activate([
                
                showButton.widthAnchor.constraint(equalToConstant: 20),
                showButton.heightAnchor.constraint(equalToConstant: 20),
            ])
        }
    }
    
    func setUpShowLabel() {
        showLabel.text = "Больше не показывать"
        showLabel.translatesAutoresizingMaskIntoConstraints = false
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            showLabel.font = UIFont(name: "Roboto-Light", size: 14)
        } else {
        showLabel.font = UIFont(name: "Roboto-Light", size: 16)
        }
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
      
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            NSLayoutConstraint.activate([
                stack.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 55),
                stack.centerXAnchor.constraint(equalTo: background.centerXAnchor),
                stack.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -18)
                
            ])
        } else {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(lessThanOrEqualTo: background.leadingAnchor, constant: 80),
            stack.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -18)
            
        ])
        }
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
