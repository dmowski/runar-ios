//
//  ProcessingViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 5.02.21.
//

import UIKit

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
        setUpImageView()
        shapeSetUp()
        
        setUpNameLabel()
        setUpStart()
        setUpProcessingLabel()
        setUpAdNameAndText()
        
        CATransaction.begin()

        CATransaction.setCompletionBlock({
            self.navigationController?.pushViewController(self.setUpNextController(), animated: true)
        })
        animationSetUp()
      CATransaction.commit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    func setUpNextController()-> AlignmentInfoViewController {
        let viewModel = AlignmentInfoViewModel(runeDescription: self.viewModel.runeDescription)
        let viewController = AlignmentInfoViewController()
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        return viewController
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
    }
    
    
    func setUpImageView() {
        imageView.image = UIImage(named: "ads")
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 83.5 : 147
        imageView.layer.cornerRadius = radiusConstant
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundFire.addSubview(imageView)
        
        let topConstant: CGFloat = DeviceType.iPhoneSE ? 138 : 202
        let bottomContant: CGFloat = DeviceType.iPhoneSE ? -215 : -318
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 76 : 60
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: backgroundFire.topAnchor, constant: topConstant),
            imageView.bottomAnchor.constraint(equalTo: backgroundFire.bottomAnchor, constant: bottomContant),
            imageView.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: leadingConstant),
            imageView.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -leadingConstant)
        ])
    }
    
    func shapeSetUp() {
       let center = CGPoint(x: imageView.bounds.midX,
                                     y: imageView.bounds.midY)
        //let center = CGPoint(x: imageView.frame.origin.x, y: imageView.frame.origin.y)
        let circularPath = UIBezierPath(arcCenter: center, radius: 147 / 414 * self.view.frame.size.width, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 2, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1).cgColor
        shapeLayer.lineWidth = 2
        backgroundFire.layer.addSublayer(shapeLayer)
    }
    
    func animationSetUp () {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 15
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "animation")
        
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
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backgroundFire.topAnchor, constant: 25),
            nameLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 65),
            nameLabel.centerXAnchor.constraint(equalTo: backgroundFire.centerXAnchor)
        ])
    }
    
    func setUpStart() {
        startButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        startButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        startButton.layer.cornerRadius = 8
        startButton.layer.borderWidth = 1
        startButton.setTitle("Перейти на сайт", for: .normal)
        
        vectorImageView.image = UIImage(named: "vector")
        vectorImageView.translatesAutoresizingMaskIntoConstraints = false
        startButton.addSubview(vectorImageView)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        startButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        backgroundFire.addSubview(startButton)
        
        let buttonBottomConstant: CGFloat = DeviceType.iPhoneSE ? -55 : -65
        let buttonTopConstant: CGFloat = DeviceType.iPhoneSE ? -46 : -54
        let buttonLeadingConstant: CGFloat = DeviceType.iPhoneSE ? 55 : 80
        let buttonWidthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        
        let vectorTop: CGFloat = DeviceType.iPhoneSE ? 17.25 : 21
        let vectorTrailing: CGFloat = DeviceType.iPhoneSE ? -18.76 : -22.84
        let vectorWidth: CGFloat = DeviceType.iPhoneSE ? 15.74 : 19.16
        let vectorHeight: CGFloat = DeviceType.iPhoneSE ? 10.68 : 13
            
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: backgroundFire.bottomAnchor, constant: buttonBottomConstant),
            startButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: buttonTopConstant),
            startButton.leadingAnchor.constraint(lessThanOrEqualTo: backgroundFire.leadingAnchor, constant: buttonLeadingConstant),
            startButton.widthAnchor.constraint(equalToConstant: buttonWidthConsatnt),
            startButton.centerXAnchor.constraint(equalTo: backgroundFire.centerXAnchor),
       
            vectorImageView.topAnchor.constraint(equalTo: startButton.topAnchor, constant: vectorTop),
            vectorImageView.trailingAnchor.constraint(equalTo: startButton.trailingAnchor, constant: vectorTrailing),
            vectorImageView.widthAnchor.constraint(equalToConstant: vectorWidth),
            vectorImageView.heightAnchor.constraint(equalToConstant: vectorHeight),
        ])
    }
    
    func setUpProcessingLabel() {
        processingLabel.text = "Расклад обрабатывается..."
        processingLabel.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 12 : 16
        processingLabel.font = FontFamily.Roboto.light.font(size: fontConstant)
        
        processingLabel.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        processingLabel.textAlignment = .center
        
        backgroundFire.addSubview(processingLabel)
        
        NSLayoutConstraint.activate([
            processingLabel.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: 50),
            processingLabel.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -50),
            processingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            processingLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    func setUpAdNameAndText () {
        
        adName.text = "Wardruna"
        adName.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        adName.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        adName.textAlignment = .center
        
        adText.text = "Helvegen"
        adText.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        adText.font = UIFont(name: "SFProDisplay-Light", size: 16)
        adText.textAlignment = .center
        
        adName.translatesAutoresizingMaskIntoConstraints = false
        adText.translatesAutoresizingMaskIntoConstraints = false
        backgroundFire.addSubview(adName)
        backgroundFire.addSubview(adText)
        
        NSLayoutConstraint.activate([
            adName.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: 60),
            adName.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -60),
            adName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            adName.bottomAnchor.constraint(equalTo: adName.topAnchor, constant: 25),
            
            adText.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: 60),
            adText.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -60),
            adText.topAnchor.constraint(equalTo: adName.bottomAnchor, constant: 4),
            adText.bottomAnchor.constraint(equalTo: adText.topAnchor, constant: 25),
        ])
    }
}


