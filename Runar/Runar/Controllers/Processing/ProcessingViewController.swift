//
//  ProcessingViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 5.02.21.
//

import UIKit

extension String {
    static let lyod = L10n.Music.lyod
    static let blackRook = L10n.Music.blackRook
    static let myMotherTold = L10n.Music.myMotherTold
}

class ProcessingViewController: UIViewController {
    
    var backgroundFire = UIImageView()
    let shapeLayer = CAShapeLayer()
    let imageView = UIImageView()
    var name = String()
    var nameLabel = UILabel()
    var startButton = UIButton()
    var vectorImageView = UIImageView()
    var processingLabel = UILabel()
    var adName = UILabel()
    var adText = UILabel()
    
    var viewModel: ProcessingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundSetup()
        
        setUpNameLabel()
        setUpStart()
        setUpProcessingLabel()
        setUpImageView()
        setUpAdNameAndText()
        fillContent()
        
        CATransaction.begin()

        CATransaction.setCompletionBlock({
            self.viewModel.closeTransition()
        })
        shapeSetUp()
        animationSetUp()
      CATransaction.commit()
        
    }

    func setUpNextController()-> AlignmentViewController {
        let viewModel = AlignmentViewModel(runeDescription: self.viewModel.runeDescription)
        let viewController = AlignmentViewController()
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
    
    func backgroundSetup() {
        backgroundFire.image = Assets.mainFire.image
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
    }
    
    
    func setUpImageView() {
                
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 83.5 : 147.heightDependent()
        imageView.layer.cornerRadius = radiusConstant
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundFire.addSubview(imageView)
        
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 167 : 294.heightDependent()
        let topConstant: CGFloat = DeviceType.iPhoneSE ? 70 : 93.heightDependent()
       
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: processingLabel.bottomAnchor, constant: topConstant),
            imageView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: heightConstant),
            imageView.centerXAnchor.constraint(equalTo: backgroundFire.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: heightConstant)
        ])
        view.layoutIfNeeded()
    }
    
    func shapeSetUp() {
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 83.5 : 147.heightDependent()
        let center = CGPoint(x: imageView.frame.midX, y: imageView.frame.midY)
        let startAngle: CGFloat = -0.25 * 2 * .pi
        let endAngle: CGFloat = startAngle + 2 * .pi
        let circularPath = UIBezierPath(arcCenter: center, radius: radiusConstant, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1).cgColor
        shapeLayer.lineWidth = 2
        backgroundFire.layer.addSublayer(shapeLayer)
    }
    
    func animationSetUp () {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        basicAnimation.duration = 15
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: nil)
        
    }

    
    func setUpNameLabel() {
        nameLabel.text = viewModel.name
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 45 : 55
        nameLabel.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor =  UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -1.1])
        backgroundFire.addSubview(nameLabel)
        let nameLabelTop: CGFloat = DeviceType.iPhoneSE ? 35 : 57.heightDependent()
        let nameLabelHeight: CGFloat = DeviceType.iPhoneSE ? 75 : 90
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backgroundFire.topAnchor, constant: nameLabelTop),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight),
            nameLabel.centerXAnchor.constraint(equalTo: backgroundFire.centerXAnchor)
        ])
    }
    
    func setUpStart() {
        startButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        startButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        startButton.layer.cornerRadius = 8
        startButton.layer.borderWidth = 1
        startButton.setTitle(L10n.goToTheSite, for: .normal)
        
        vectorImageView.image = Assets.vector.image
        vectorImageView.translatesAutoresizingMaskIntoConstraints = false
        startButton.addSubview(vectorImageView)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        startButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        backgroundFire.addSubview(startButton)
        
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        let buttonWidthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        
        let vectorTop: CGFloat = DeviceType.iPhoneSE ? 17.25 : 21
        let vectorTrailing: CGFloat = DeviceType.iPhoneSE ? -18.76 : -22.84
        let vectorWidth: CGFloat = DeviceType.iPhoneSE ? 15.74 : 19.16
        let vectorHeight: CGFloat = DeviceType.iPhoneSE ? 10.68 : 13
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: backgroundFire.bottomAnchor, constant: -40.heightDependent()),
            startButton.widthAnchor.constraint(equalToConstant: buttonWidthConsatnt),
            startButton.heightAnchor.constraint(equalToConstant: heightConstant),
            startButton.centerXAnchor.constraint(equalTo: backgroundFire.centerXAnchor),
       
            vectorImageView.topAnchor.constraint(equalTo: startButton.topAnchor, constant: vectorTop),
            vectorImageView.trailingAnchor.constraint(equalTo: startButton.trailingAnchor, constant: vectorTrailing),
            vectorImageView.widthAnchor.constraint(equalToConstant: vectorWidth),
            vectorImageView.heightAnchor.constraint(equalToConstant: vectorHeight),
        ])
    }
    
    func setUpProcessingLabel() {
        processingLabel.text = L10n.layoutProcessing
        processingLabel.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 12 : 16
        processingLabel.font = FontFamily.Roboto.light.font(size: fontConstant)
        
        processingLabel.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        processingLabel.textAlignment = .center
        
        backgroundFire.addSubview(processingLabel)
        let processingTop: CGFloat = DeviceType.iPhoneSE ? 6 : 15
        NSLayoutConstraint.activate([
            processingLabel.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: 50),
            processingLabel.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -50),
            processingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: processingTop),
            processingLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    func setUpAdNameAndText () {
        
        let nameFontConstant: CGFloat = DeviceType.iPhoneSE ? 16 : 24
        adName.font = FontFamily.SFProDisplay.regular.font(size: nameFontConstant)
        
        adName.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        adName.textAlignment = .center
        
        adText.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        let addFontConst: CGFloat =  DeviceType.iPhoneSE ? 11 : 16
        adText.font = FontFamily.SFProDisplay.light.font(size: addFontConst)
        adText.textAlignment = .center
        
        adName.translatesAutoresizingMaskIntoConstraints = false
        adText.translatesAutoresizingMaskIntoConstraints = false
        backgroundFire.addSubview(adName)
        backgroundFire.addSubview(adText)
        
        NSLayoutConstraint.activate([
            adName.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: 60),
            adName.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -60),
            adName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24.heightDependent()),
            adName.bottomAnchor.constraint(equalTo: adName.topAnchor, constant: 25),
            
            adText.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: 60),
            adText.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -60),
            adText.topAnchor.constraint(equalTo: adName.bottomAnchor, constant: 4),
            adText.bottomAnchor.constraint(equalTo: adText.topAnchor, constant: 25),
        ])
    }
    
    private func fillContent() {
        switch MusicViewController.shared.currentSoundsIndex {
        case 0:
            imageView.image = Assets.led.image
            adName.text = String.lyod
            adText.text = String.myMotherTold
        case 1:
            imageView.image = Assets.led.image
            adName.text = String.lyod
            adText.text = String.blackRook
        case 2:
            imageView.image = Assets.danheim.image
            adName.text = "Danheim"
            adText.text = "Runar"
        case 3:
            imageView.image = Assets.danheim.image
            adName.text = "Danheim"
            adText.text = "Kala"
        default:
            imageView.image = nil
        }
    }
}

