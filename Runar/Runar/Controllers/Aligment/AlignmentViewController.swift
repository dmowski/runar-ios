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
    private let aligmentOneButton = UIButton()
    private let aligmentTwoButton = UIButton()
    private let aligmentThreeButton = UIButton()
    private let aligmentFourButton = UIButton()
    private let aligmentFiveButton = UIButton()
    private let aligmentSixButton = UIButton()
    private let aligmentSevenButton = UIButton()
    
    public var viewModel: AlignmentViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        runesViewContainer.setRuneLayout(viewModel.runeLayout)
        
        backgroundSetup()
        setUpEscape()
        setUpNameLabel()
        setUpStart()
        setUpAligmentButton()
        setUpContainerView()
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
        let image = UIImage(named: "escape")
        escapeButton.setImage(image, for: .normal)
        backgroundView.addSubview(escapeButton)
        escapeButton.addTarget(self, action: #selector(self.escapeOnTap), for: .touchUpInside)
        
        let constant: CGFloat = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 ? 40: 48

        NSLayoutConstraint.activate([
            escapeButton.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            escapeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            escapeButton.widthAnchor.constraint(equalToConstant: constant),
            escapeButton.bottomAnchor.constraint(equalTo: escapeButton.topAnchor, constant: constant)
        ])
    }
    
    @objc func escapeOnTap (sender: UIButton!) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUpNameLabel() {
        nameLabel.text = name
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
        nameLabel.font = UIFont(name: "AmaticSC-Bold", size: 45)
        } else {
            nameLabel.font = UIFont(name: "AmaticSC-Bold", size: 55)
        }
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor =  UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        
        backgroundView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 25),
            nameLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 65),
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
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            startButton.titleLabel?.font = UIFont(name: "AmaticSC-Bold", size: 24)
        } else {
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 30)
        }
        startButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        backgroundView.addSubview(startButton)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            NSLayoutConstraint.activate([
                startButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -55),
                startButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: -46),
                    startButton.leadingAnchor.constraint(lessThanOrEqualTo: backgroundView.leadingAnchor, constant: 55),
                startButton.widthAnchor.constraint(equalToConstant: 210),
                startButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
            ])
        } else {
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -79),
            startButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: -54),
                startButton.leadingAnchor.constraint(lessThanOrEqualTo: backgroundView.leadingAnchor, constant: 80),
            startButton.widthAnchor.constraint(equalToConstant: 255),
            startButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
        }
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
    
    func setUpAligmentButton() {
        
//        switch self.name {
//        case "Руна дня":
//            aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//                   aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//                   aligmentOneButton.layer.cornerRadius = 25
//                   aligmentOneButton.layer.borderWidth = 1
//                   aligmentOneButton.setTitle("1", for: .normal)
//
//
//                   aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//                   if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//                       aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//                   } else {
//                       aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//                   }
//                   aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//                   aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//                   containerView.addSubview(aligmentOneButton)
//
//                       NSLayoutConstraint.activate([
//                           aligmentOneButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//                           aligmentOneButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//                           aligmentOneButton.widthAnchor.constraint(equalToConstant: 68),
//                           aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
//                       ])
//        case "Расклад из 2 рун":
//            aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//                    aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//                    aligmentOneButton.layer.cornerRadius = 25
//                    aligmentOneButton.layer.borderWidth = 1
//                    aligmentOneButton.setTitle("1", for: .normal)
//
//                    aligmentTwoButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//                    aligmentTwoButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//                    aligmentTwoButton.layer.cornerRadius = 25
//                    aligmentTwoButton.layer.borderWidth = 1
//                    aligmentTwoButton.setTitle("2", for: .normal)
//
//
//                    aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//                    aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
//
//                    if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//                        aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//                    } else {
//                        aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//                    }
//                    aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//                    aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//                    containerView.addSubview(aligmentOneButton)
//
//                    if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//                        aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//                    } else {
//                        aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//                    }
//                    aligmentTwoButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//                    aligmentTwoButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//                    containerView.addSubview(aligmentTwoButton)
//
//                    NSLayoutConstraint.activate([
//                        aligmentOneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -127),
//                        aligmentOneButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//                        aligmentOneButton.leadingAnchor.constraint(equalTo: aligmentOneButton.trailingAnchor, constant: -68),
//                        aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
//                    ])
//                    NSLayoutConstraint.activate([
//                        aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: -24),
//                        aligmentTwoButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//                        aligmentTwoButton.widthAnchor.constraint(equalToConstant: 68),
//                        aligmentTwoButton.heightAnchor.constraint(equalToConstant: 90),
//                    ])
//        default:
//            "error"
//        }
        
        /// - РАсклад на 1 руну
        
//        aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentOneButton.layer.cornerRadius = 25
//        aligmentOneButton.layer.borderWidth = 1
//        aligmentOneButton.setTitle("1", for: .normal)
//
//
//        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentOneButton)
//
//            NSLayoutConstraint.activate([
//                aligmentOneButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//                aligmentOneButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//                aligmentOneButton.widthAnchor.constraint(equalToConstant: 68),
//                aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
//            ])

        
/// - Расклад на руну 2
        
//        aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentOneButton.layer.cornerRadius = 25
//        aligmentOneButton.layer.borderWidth = 1
//        aligmentOneButton.setTitle("1", for: .normal)
//
//        aligmentTwoButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentTwoButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentTwoButton.layer.cornerRadius = 25
//        aligmentTwoButton.layer.borderWidth = 1
//        aligmentTwoButton.setTitle("2", for: .normal)
//
//
//        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentOneButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentTwoButton)
//
//        NSLayoutConstraint.activate([
//            aligmentOneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -127),
//            aligmentOneButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            aligmentOneButton.leadingAnchor.constraint(equalTo: aligmentOneButton.trailingAnchor, constant: -68),
//            aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: -24),
//            aligmentTwoButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            aligmentTwoButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentTwoButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
        
        
/// Расклад на руну 3
        
//        aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentOneButton.layer.cornerRadius = 25
//        aligmentOneButton.layer.borderWidth = 1
//        aligmentOneButton.setTitle("1", for: .normal)
//
//        aligmentTwoButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentTwoButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentTwoButton.layer.cornerRadius = 25
//        aligmentTwoButton.layer.borderWidth = 1
//        aligmentTwoButton.setTitle("2", for: .normal)
//
//        aligmentThreeButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentThreeButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentThreeButton.layer.cornerRadius = 25
//        aligmentThreeButton.layer.borderWidth = 1
//        aligmentThreeButton.setTitle("3", for: .normal)
//
//
//        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentThreeButton.translatesAutoresizingMaskIntoConstraints = false
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentOneButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentTwoButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentThreeButton)
//
//        NSLayoutConstraint.activate([
//            aligmentOneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -81),
//            aligmentOneButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            aligmentOneButton.leadingAnchor.constraint(equalTo: aligmentOneButton.trailingAnchor, constant: -68),
//            aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: -24),
//            aligmentTwoButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            aligmentTwoButton.leadingAnchor.constraint(equalTo: aligmentTwoButton.trailingAnchor, constant: -68),
//            aligmentTwoButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentThreeButton.trailingAnchor.constraint(equalTo: aligmentTwoButton.leadingAnchor, constant: -24),
//            aligmentThreeButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            aligmentThreeButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentThreeButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
        
/// Расклад на руну 4
        
//        aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentOneButton.layer.cornerRadius = 25
//        aligmentOneButton.layer.borderWidth = 1
//        aligmentOneButton.setTitle("1", for: .normal)
//
//        aligmentTwoButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentTwoButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentTwoButton.layer.cornerRadius = 25
//        aligmentTwoButton.layer.borderWidth = 1
//        aligmentTwoButton.setTitle("2", for: .normal)
//
//        aligmentThreeButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentThreeButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentThreeButton.layer.cornerRadius = 25
//        aligmentThreeButton.layer.borderWidth = 1
//        aligmentThreeButton.setTitle("3", for: .normal)
//
//        aligmentFourButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentFourButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentFourButton.layer.cornerRadius = 25
//        aligmentFourButton.layer.borderWidth = 1
//        aligmentFourButton.setTitle("4", for: .normal)
//
//
//        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentThreeButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentFourButton.translatesAutoresizingMaskIntoConstraints = false
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentOneButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentTwoButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentThreeButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentFourButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentFourButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentFourButton)
//
//        NSLayoutConstraint.activate([
//            aligmentOneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -127),
//            aligmentOneButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            aligmentOneButton.leadingAnchor.constraint(equalTo: aligmentOneButton.trailingAnchor, constant: -68),
//            aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: -24),
//            aligmentTwoButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            aligmentTwoButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentTwoButton.topAnchor.constraint(equalTo: aligmentTwoButton.bottomAnchor, constant: -90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentThreeButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentThreeButton.heightAnchor.constraint(equalToConstant: 90),
//            aligmentThreeButton.topAnchor.constraint(equalTo: aligmentTwoButton.bottomAnchor, constant: 24),
//            aligmentThreeButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: -24)
//        ])
//        NSLayoutConstraint.activate([
//            aligmentFourButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentFourButton.heightAnchor.constraint(equalToConstant: 90),
//            aligmentFourButton.bottomAnchor.constraint(equalTo: aligmentTwoButton.topAnchor, constant: -24),
//            aligmentFourButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: -24)
//        ])
        
/// Расклад на руну 5
        
//        aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentOneButton.layer.cornerRadius = 25
//        aligmentOneButton.layer.borderWidth = 1
//        aligmentOneButton.setTitle("1", for: .normal)
//
//        aligmentTwoButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentTwoButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentTwoButton.layer.cornerRadius = 25
//        aligmentTwoButton.layer.borderWidth = 1
//        aligmentTwoButton.setTitle("2", for: .normal)
//
//        aligmentThreeButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentThreeButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentThreeButton.layer.cornerRadius = 25
//        aligmentThreeButton.layer.borderWidth = 1
//        aligmentThreeButton.setTitle("3", for: .normal)
//
//        aligmentFourButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentFourButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentFourButton.layer.cornerRadius = 25
//        aligmentFourButton.layer.borderWidth = 1
//        aligmentFourButton.setTitle("4", for: .normal)
//
//        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentThreeButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentFourButton.translatesAutoresizingMaskIntoConstraints = false
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentOneButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentTwoButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentThreeButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentFourButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentFourButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentFourButton)
//
//        NSLayoutConstraint.activate([
//            aligmentOneButton.leadingAnchor.constraint(equalTo: aligmentFourButton.trailingAnchor, constant: -68),
//            aligmentOneButton.topAnchor.constraint(equalTo: aligmentFourButton.bottomAnchor, constant: 24),
//            aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
//            aligmentOneButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentThreeButton.leadingAnchor, constant: -116),
//            aligmentTwoButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            aligmentTwoButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentTwoButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentThreeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -81),
//            aligmentThreeButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            aligmentThreeButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: -68),
//            aligmentThreeButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentFourButton.leadingAnchor.constraint(equalTo: aligmentFourButton.trailingAnchor, constant: -68),
//            aligmentFourButton.bottomAnchor.constraint(equalTo: aligmentFourButton.topAnchor, constant: 90),
//            aligmentFourButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 194),
//            aligmentFourButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//        ])
        
        
        
        /// Расклад на 6 руну
        
//        aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentOneButton.layer.cornerRadius = 25
//        aligmentOneButton.layer.borderWidth = 1
//        aligmentOneButton.setTitle("1", for: .normal)
//
//        aligmentTwoButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentTwoButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentTwoButton.layer.cornerRadius = 25
//        aligmentTwoButton.layer.borderWidth = 1
//        aligmentTwoButton.setTitle("2", for: .normal)
//
//        aligmentThreeButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentThreeButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentThreeButton.layer.cornerRadius = 25
//        aligmentThreeButton.layer.borderWidth = 1
//        aligmentThreeButton.setTitle("3", for: .normal)
//
//        aligmentFourButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentFourButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentFourButton.layer.cornerRadius = 25
//        aligmentFourButton.layer.borderWidth = 1
//        aligmentFourButton.setTitle("4", for: .normal)
//
//        aligmentFiveButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentFiveButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentFiveButton.layer.cornerRadius = 25
//        aligmentFiveButton.layer.borderWidth = 1
//        aligmentFiveButton.setTitle("5", for: .normal)
//
//        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentThreeButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentFourButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentFiveButton.translatesAutoresizingMaskIntoConstraints = false
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentOneButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentTwoButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentThreeButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentFourButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentFourButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentFourButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentFiveButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentFiveButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentFiveButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentFiveButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentFiveButton)
//
//        NSLayoutConstraint.activate([
//            aligmentOneButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 81),
//            aligmentOneButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: 68),
//            aligmentOneButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 251),
//            aligmentOneButton.bottomAnchor.constraint(equalTo: aligmentOneButton.topAnchor, constant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentTwoButton.leadingAnchor.constraint(equalTo: aligmentOneButton.trailingAnchor, constant: 24),
//            aligmentTwoButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 251),
//            aligmentTwoButton.bottomAnchor.constraint(equalTo: aligmentOneButton.topAnchor, constant: 90),
//            aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentTwoButton.leadingAnchor, constant: 68),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentThreeButton.leadingAnchor.constraint(equalTo: aligmentTwoButton.trailingAnchor, constant: 24),
//            aligmentThreeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 251),
//            aligmentThreeButton.bottomAnchor.constraint(equalTo: aligmentThreeButton.topAnchor, constant: 90),
//            aligmentThreeButton.trailingAnchor.constraint(equalTo: aligmentThreeButton.leadingAnchor, constant: 68),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentFourButton.bottomAnchor.constraint(equalTo: aligmentTwoButton.topAnchor, constant: -24),
//            aligmentFourButton.leadingAnchor.constraint(equalTo: aligmentOneButton.trailingAnchor, constant: 24),
//            aligmentFourButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentFourButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentFiveButton.topAnchor.constraint(equalTo: aligmentTwoButton.bottomAnchor, constant: 24),
//            aligmentFiveButton.leadingAnchor.constraint(equalTo: aligmentOneButton.trailingAnchor, constant: 24),
//            aligmentFiveButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentFiveButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
        
        /// Расклад на 7 ячейку
        
//        aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentOneButton.layer.cornerRadius = 25
//        aligmentOneButton.layer.borderWidth = 1
//        aligmentOneButton.setTitle("1", for: .normal)
//
//        aligmentTwoButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentTwoButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentTwoButton.layer.cornerRadius = 25
//        aligmentTwoButton.layer.borderWidth = 1
//        aligmentTwoButton.setTitle("2", for: .normal)
//
//        aligmentThreeButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentThreeButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentThreeButton.layer.cornerRadius = 25
//        aligmentThreeButton.layer.borderWidth = 1
//        aligmentThreeButton.setTitle("3", for: .normal)
//
//        aligmentFourButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentFourButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentFourButton.layer.cornerRadius = 25
//        aligmentFourButton.layer.borderWidth = 1
//        aligmentFourButton.setTitle("4", for: .normal)
//
//        aligmentFiveButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentFiveButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentFiveButton.layer.cornerRadius = 25
//        aligmentFiveButton.layer.borderWidth = 1
//        aligmentFiveButton.setTitle("5", for: .normal)
//
//        aligmentSixButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentSixButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentSixButton.layer.cornerRadius = 25
//        aligmentSixButton.layer.borderWidth = 1
//        aligmentSixButton.setTitle("6", for: .normal)
//
//        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentThreeButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentFourButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentFiveButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentSixButton.translatesAutoresizingMaskIntoConstraints = false
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentOneButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentTwoButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentThreeButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentFourButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentFourButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentFourButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentFiveButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentFiveButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentFiveButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentFiveButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentFiveButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentSixButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentSixButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentSixButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentSixButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentSixButton)
//
//        NSLayoutConstraint.activate([
//            aligmentThreeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 81),
//            aligmentThreeButton.trailingAnchor.constraint(equalTo: aligmentThreeButton.leadingAnchor, constant: 68),
//            aligmentThreeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 251),
//            aligmentThreeButton.bottomAnchor.constraint(equalTo: aligmentThreeButton.topAnchor, constant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentTwoButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
//            aligmentTwoButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 251),
//            aligmentTwoButton.bottomAnchor.constraint(equalTo: aligmentThreeButton.topAnchor, constant: 90),
//            aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentTwoButton.leadingAnchor, constant: 68),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentOneButton.leadingAnchor.constraint(equalTo: aligmentTwoButton.trailingAnchor, constant: 24),
//            aligmentOneButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 251),
//            aligmentOneButton.bottomAnchor.constraint(equalTo: aligmentOneButton.topAnchor, constant: 90),
//            aligmentOneButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: 68),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentFiveButton.bottomAnchor.constraint(equalTo: aligmentTwoButton.topAnchor, constant: -24),
//            aligmentFiveButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
//            aligmentFiveButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentFiveButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentFourButton.topAnchor.constraint(equalTo: aligmentTwoButton.bottomAnchor, constant: 24),
//            aligmentFourButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
//            aligmentFourButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentFourButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentSixButton.bottomAnchor.constraint(equalTo: aligmentFiveButton.topAnchor, constant: -24),
//            aligmentSixButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
//            aligmentSixButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentSixButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
        
        
        /// Расклад на 8 ячейку
        
//        aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentOneButton.layer.cornerRadius = 25
//        aligmentOneButton.layer.borderWidth = 1
//        aligmentOneButton.setTitle("1", for: .normal)
//
//        aligmentTwoButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentTwoButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentTwoButton.layer.cornerRadius = 25
//        aligmentTwoButton.layer.borderWidth = 1
//        aligmentTwoButton.setTitle("2", for: .normal)
//
//        aligmentThreeButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentThreeButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentThreeButton.layer.cornerRadius = 25
//        aligmentThreeButton.layer.borderWidth = 1
//        aligmentThreeButton.setTitle("3", for: .normal)
//
//        aligmentFourButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentFourButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentFourButton.layer.cornerRadius = 25
//        aligmentFourButton.layer.borderWidth = 1
//        aligmentFourButton.setTitle("4", for: .normal)
//
//        aligmentFiveButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentFiveButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentFiveButton.layer.cornerRadius = 25
//        aligmentFiveButton.layer.borderWidth = 1
//        aligmentFiveButton.setTitle("5", for: .normal)
//
//        aligmentSixButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentSixButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentSixButton.layer.cornerRadius = 25
//        aligmentSixButton.layer.borderWidth = 1
//        aligmentSixButton.setTitle("6", for: .normal)
//
//        aligmentSevenButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
//        aligmentSevenButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
//        aligmentSevenButton.layer.cornerRadius = 25
//        aligmentSevenButton.layer.borderWidth = 1
//        aligmentSevenButton.setTitle("7", for: .normal)
//
//        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentThreeButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentFourButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentFiveButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentSixButton.translatesAutoresizingMaskIntoConstraints = false
//        aligmentSevenButton.translatesAutoresizingMaskIntoConstraints = false
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentOneButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentTwoButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentTwoButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentThreeButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentThreeButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentFourButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentFourButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentFourButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentFiveButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentFiveButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentFiveButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentFiveButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentFiveButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentSixButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentSixButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentSixButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentSixButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentSixButton)
//
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            aligmentSevenButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        } else {
//            aligmentSevenButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
//        }
//        aligmentSevenButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
//        aligmentSevenButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
//        containerView.addSubview(aligmentSevenButton)
//
//        NSLayoutConstraint.activate([
//            aligmentThreeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 81),
//            aligmentThreeButton.trailingAnchor.constraint(equalTo: aligmentThreeButton.leadingAnchor, constant: 68),
//            aligmentThreeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 251),
//            aligmentThreeButton.bottomAnchor.constraint(equalTo: aligmentThreeButton.topAnchor, constant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentOneButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
//            aligmentOneButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 251),
//            aligmentOneButton.bottomAnchor.constraint(equalTo: aligmentThreeButton.topAnchor, constant: 90),
//            aligmentOneButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: 68),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentTwoButton.leadingAnchor.constraint(equalTo: aligmentOneButton.trailingAnchor, constant: 24),
//            aligmentTwoButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 251),
//            aligmentTwoButton.bottomAnchor.constraint(equalTo: aligmentTwoButton.topAnchor, constant: 90),
//            aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentTwoButton.leadingAnchor, constant: 68),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentFourButton.topAnchor.constraint(equalTo: aligmentFiveButton.bottomAnchor, constant: 24),
//            aligmentFourButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
//            aligmentFourButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentFourButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentFiveButton.topAnchor.constraint(equalTo: aligmentTwoButton.bottomAnchor, constant: 24),
//            aligmentFiveButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
//            aligmentFiveButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentFiveButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentSixButton.bottomAnchor.constraint(equalTo: aligmentOneButton.topAnchor, constant: -24),
//            aligmentSixButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
//            aligmentSixButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentSixButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//        NSLayoutConstraint.activate([
//            aligmentSevenButton.bottomAnchor.constraint(equalTo: aligmentSixButton.topAnchor, constant: -24),
//            aligmentSevenButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
//            aligmentSevenButton.widthAnchor.constraint(equalToConstant: 68),
//            aligmentSevenButton.heightAnchor.constraint(equalToConstant: 90),
//        ])
//
        }
}

