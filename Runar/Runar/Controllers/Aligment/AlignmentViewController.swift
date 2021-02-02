//
//  AlignmentViewController.swift
//  Runar
//
//  Created by Oleg Kanatov on 20.01.21.
//

import UIKit

class AlignmentViewController: UIViewController {
    
    private let backgroundView = UIImageView()
    private let escapeButton = UIButton()
    private let nameLabel = UILabel()
    var name = String()
    private let startButton = UIButton()
    var runesViewContainer = RunesView()
    private let showButton = UIButton()
    private let showLabel = UILabel()
    var stack = UIStackView()
    
    public var viewModel: AlignmentViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        runesViewContainer.update(with: .init(didHighlightAllRunes: { [weak self] runes in
            self!.startButton.setTitle("Погнали нахуй!", for: .normal)
            self!.startButton.addTarget(self, action: #selector(self?.escapeOnTap), for: .touchUpInside)
        }))
        
        
        runesViewContainer.setRuneLayout(viewModel.runeLayout)
        
        backgroundSetup()
        setUpEscape()
        setUpNameLabel()
        setUpStart()
        setUpContainerView()
        
        setUpShowButton()
        setUpShowLabel()
        setUpStack()
    }
    
    func backgroundSetup() {
        backgroundView.image = Assets.mainFire.image
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.isUserInteractionEnabled = true
        self.view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setUpEscape() {
        escapeButton.translatesAutoresizingMaskIntoConstraints = false
        let image = Assets.escape.image
        escapeButton.setImage(image, for: .normal)
        backgroundView.addSubview(escapeButton)
        escapeButton.addTarget(self, action: #selector(self.escapeOnTap), for: .touchUpInside)
        

        NSLayoutConstraint.activate([
            escapeButton.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            escapeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8.widthDependent()),
            escapeButton.widthAnchor.constraint(equalToConstant: 48.widthDependent()),
            escapeButton.bottomAnchor.constraint(equalTo: escapeButton.topAnchor, constant: 48.widthDependent())
        ])
    }
    
    @objc func escapeOnTap (sender: UIButton!) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUpNameLabel() {
        nameLabel.text = viewModel.name
      
        nameLabel.font = FontFamily.AmaticSC.bold.font(size: 55.widthDependent())
    
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = Assets.Colors.textColor.color
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        
        backgroundView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 25.widthDependent()),
            nameLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 65.widthDependent()),
            nameLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
    }
    
    func setUpStart() {
        startButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        startButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        startButton.layer.cornerRadius = 8
        startButton.layer.borderWidth = 1
        startButton.setTitle("Вытянуть руну", for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 30.widthDependent())
        startButton.addTarget(self, action: #selector(self.openButton), for: .touchUpInside)
        
        startButton.setTitleColor(Assets.Colors.textColor.color, for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        backgroundView.addSubview(startButton)
       
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -70.widthDependent()),
            startButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: -54.widthDependent()),
            startButton.leadingAnchor.constraint(lessThanOrEqualTo: backgroundView.leadingAnchor, constant: 80.widthDependent()),
            startButton.widthAnchor.constraint(equalToConstant: 255.widthDependent()),
            startButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
    }
    
    @objc func openButton (sender: UIButton!) {
        self.runesViewContainer.openHighlightedButton()
    }
    
    func setUpContainerView() {
        runesViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.addSubview(runesViewContainer)
        
        NSLayoutConstraint.activate([
            runesViewContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            runesViewContainer.bottomAnchor.constraint(equalTo: startButton.topAnchor),
            runesViewContainer.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            runesViewContainer.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
        ])
    }
    
    func setUpShowButton(){
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.layer.borderColor = Assets.Colors.textColor.color.cgColor
        showButton.layer.borderWidth = 1.widthDependent()
        showButton.layer.cornerRadius = 12.widthDependent()
        showButton.setTitle("i", for: .normal)
        showButton.titleLabel?.font = FontFamily.SFProDisplay.light.font(size: 16.widthDependent())
        backgroundView.addSubview(showButton)
        
        
            NSLayoutConstraint.activate([
                showButton.widthAnchor.constraint(equalToConstant: 24.widthDependent()),
                showButton.heightAnchor.constraint(equalToConstant: 24.widthDependent()),
            ])
    }
    
    func setUpShowLabel() {
        showLabel.text = "Узнать о раскладе"
        showLabel.translatesAutoresizingMaskIntoConstraints = false
    
       
        showLabel.font = FontFamily.SFProDisplay.light.font(size: 16.widthDependent())
        
        showLabel.textColor = Assets.Colors.textColor.color
        showLabel.textAlignment = .left
        backgroundView.addSubview(showLabel)
        
        NSLayoutConstraint.activate([
            
            showLabel.widthAnchor.constraint(equalToConstant: 150.widthDependent()),
            showLabel.heightAnchor.constraint(equalToConstant: 36.widthDependent())
            
        ])
    }
    
    func setUpStack() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 12.widthDependent()
        
        backgroundView.addSubview(stack)
        stack.addArrangedSubview(showButton)
        stack.addArrangedSubview(showLabel)
      
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            stack.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 27.widthDependent())
        ])
    }
}


