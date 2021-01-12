//
//  AlignmentInfoViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 19.12.20.
//

import UIKit

class AlignmentInfoViewController: UIViewController {
    
    private static let nameFontMultiplier = 55/785
    var background = UIImageView()
    var name = String()
    var nameLabel = UILabel()
    var startButton = UIButton()
    var escape = UIButton()
    var descriptionLabel = UILabel()
    var showLabel = UILabel()
    var showButton = UIButton()
    var selected: Bool = false
    var stack = UIStackView()
    
    
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        self.name = name
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func backgroundSetup() {
        background.image = UIImage(named: "main_fire")
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .scaleAspectFill
        background.isUserInteractionEnabled = true
        self.view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setUpNameLabel() {
        nameLabel.text = name
        nameLabel.font = UIFont(name: "AmaticSC-Bold", size: 55)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor =  UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        
        background.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 55),
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
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.titleLabel?.font = UIFont(name: "AmaticSC-Bold", size: 30)
        startButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        background.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -78),
            startButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: -54),
                startButton.leadingAnchor.constraint(lessThanOrEqualTo: background.leadingAnchor, constant: 80),
            startButton.widthAnchor.constraint(equalToConstant: 255),
            startButton.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        ])
        
    }
    
    func setUpEscape() {
        escape.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "escape")
        let width = 48
        let height = 48
        escape.setImage(image, for: .normal)
        background.addSubview(escape)
        escape.addTarget(self, action: #selector(self.escapeOnTap), for: .touchUpInside)
        NSLayoutConstraint.activate([
            escape.topAnchor.constraint(equalTo: background.topAnchor, constant: 21),
            escape.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -28),
            escape.widthAnchor.constraint(equalToConstant: CGFloat(width)),
            escape.bottomAnchor.constraint(equalTo: escape.topAnchor, constant: CGFloat(height))
        ])
    }
    
    
    @objc func escapeOnTap (sender: UIButton!) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUpDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.text = DataBase.alDescription[name]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.34
        descriptionLabel.attributedText = NSMutableAttributedString(string: descriptionLabel.text!, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        descriptionLabel.textColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        descriptionLabel.font = UIFont(name: "SFProDisplay-Light", size: 20)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.sizeToFit()
        background.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -30),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: startButton.bottomAnchor, constant: -100),
        ])
    }
    

    
    func setUpShowButton(){
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.setImage(UIImage(named: "unselected"), for: .normal)
        background.addSubview(showButton)
        showButton.addTarget(self, action: #selector(select), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            showButton.widthAnchor.constraint(equalToConstant: 20),
            showButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func setUpShowLabel() {
        showLabel.text = "Больше не показывать"
        showLabel.translatesAutoresizingMaskIntoConstraints = false
        showLabel.font = UIFont(name: "Roboto-Light", size: 16)
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
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(lessThanOrEqualTo: background.leadingAnchor, constant: 80),
            stack.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -18)
            
        ])
    }
    
    @objc func select(sender: UIButton!) {
        if let button = sender {
                   if button.isSelected {
                    showButton.setImage(UIImage(named: "unselected"), for: .normal)
                       button.isSelected = false
                    selected = false
                      } else {
                        showButton.setImage(UIImage(named: "selected"), for: .selected)
                       button.isSelected = true
                        selected = true
                      }
                  }
    }
}
