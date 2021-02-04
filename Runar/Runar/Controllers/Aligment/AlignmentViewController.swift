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

            self?.startButton.setTitle("Толковать", for: .normal)
            self?.startButton.addTarget(self, action: #selector(self?.escapeOnTap), for: .touchUpInside)

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

            escapeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8.heightDependent()),
            escapeButton.widthAnchor.constraint(equalToConstant: 48.heightDependent()),
            escapeButton.bottomAnchor.constraint(equalTo: escapeButton.topAnchor, constant: 48.heightDependent())

        ])
    }
    
    @objc func escapeOnTap (sender: UIButton!) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUpNameLabel() {
        nameLabel.text = viewModel.name
      

        nameLabel.font = FontFamily.AmaticSC.bold.font(size: 55.heightDependent())

    
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = Assets.Colors.textColor.color
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        
        backgroundView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([

            nameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 25.heightDependent()),
            nameLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 65.heightDependent()),

            nameLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
    }
    
    func setUpStart() {
        startButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        startButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor

        startButton.layer.cornerRadius = 8.heightDependent()
        startButton.layer.borderWidth = 1.heightDependent()
        startButton.setTitle("Вытянуть руну", for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 30.heightDependent())

        startButton.addTarget(self, action: #selector(self.openButton), for: .touchUpInside)
        
        startButton.setTitleColor(Assets.Colors.textColor.color, for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        backgroundView.addSubview(startButton)
       
        NSLayoutConstraint.activate([

            startButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -82.heightDependent()),
            startButton.heightAnchor.constraint(equalToConstant: 56.heightDependent()),
            startButton.widthAnchor.constraint(equalToConstant: 255.heightDependent()),

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

        showButton.layer.borderWidth = 1.heightDependent()
        showButton.layer.cornerRadius = 12.heightDependent()
        showButton.setTitle("i", for: .normal)
        showButton.titleLabel?.font = FontFamily.SFProDisplay.light.font(size: 16.heightDependent())

        backgroundView.addSubview(showButton)
        
        
            NSLayoutConstraint.activate([

                showButton.widthAnchor.constraint(equalToConstant: 24.heightDependent()),
                showButton.heightAnchor.constraint(equalToConstant: 24.heightDependent()),

            ])
    }
    
    func setUpShowLabel() {
        showLabel.text = "Узнать о раскладе"
        showLabel.translatesAutoresizingMaskIntoConstraints = false
    
       

        showLabel.font = FontFamily.SFProDisplay.light.font(size: 16.heightDependent())

        
        showLabel.textColor = Assets.Colors.textColor.color
        showLabel.textAlignment = .left
        backgroundView.addSubview(showLabel)
        
        NSLayoutConstraint.activate([
            

            showLabel.widthAnchor.constraint(equalToConstant: 150.heightDependent()),
            showLabel.heightAnchor.constraint(equalToConstant: 36.heightDependent())

            
        ])
    }
    
    func setUpStack() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing

        stack.spacing = 12.heightDependent()

        
        backgroundView.addSubview(stack)
        stack.addArrangedSubview(showButton)
        stack.addArrangedSubview(showLabel)
      
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),

            stack.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 27.heightDependent())

        ])
    }
}


