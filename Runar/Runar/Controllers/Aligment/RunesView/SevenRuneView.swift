//
//  SevenRuneView.swift
//  Runar
//
//  Created by Oleg Kanatov on 24.01.21.
//

import UIKit

class SevenRuneView: UIView {
    
    private let aligmentOneButton = UIButton()
    private let aligmentTwoButton = UIButton()
    private let aligmentThreeButton = UIButton()
    private let aligmentFourButton = UIButton()
    private let aligmentFiveButton = UIButton()
    private let aligmentSixButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContent()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpContent()
    }
    
    func setUpContent() {
        aligmentOneButton.backgroundColor = Assets.Colors.Touch.layerBackground.color
        aligmentOneButton.layer.borderColor = Assets.Colors.Touch.layerBorder.color.cgColor
        aligmentOneButton.layer.cornerRadius = 25
        aligmentOneButton.layer.borderWidth = 2
        aligmentOneButton.setTitle("1", for: .normal)
        
        aligmentTwoButton.backgroundColor = Assets.Colors.UnTouch.layerBackground.color
        aligmentTwoButton.layer.borderColor = Assets.Colors.UnTouch.layerBorder.color.cgColor
        aligmentTwoButton.layer.cornerRadius = 25
        aligmentTwoButton.layer.borderWidth = 1
        aligmentTwoButton.setTitle("2", for: .normal)
        
        aligmentThreeButton.backgroundColor = Assets.Colors.UnTouch.layerBackground.color
        aligmentThreeButton.layer.borderColor = Assets.Colors.UnTouch.layerBorder.color.cgColor
        aligmentThreeButton.layer.cornerRadius = 25
        aligmentThreeButton.layer.borderWidth = 1
        aligmentThreeButton.setTitle("3", for: .normal)
        
        aligmentFourButton.backgroundColor = Assets.Colors.UnTouch.layerBackground.color
        aligmentFourButton.layer.borderColor = Assets.Colors.UnTouch.layerBorder.color.cgColor
        aligmentFourButton.layer.cornerRadius = 25
        aligmentFourButton.layer.borderWidth = 1
        aligmentFourButton.setTitle("4", for: .normal)
        
        aligmentFiveButton.backgroundColor = Assets.Colors.UnTouch.layerBackground.color
        aligmentFiveButton.layer.borderColor = Assets.Colors.UnTouch.layerBorder.color.cgColor
        aligmentFiveButton.layer.cornerRadius = 25
        aligmentFiveButton.layer.borderWidth = 1
        aligmentFiveButton.setTitle("5", for: .normal)
        
        aligmentSixButton.backgroundColor = Assets.Colors.UnTouch.layerBackground.color
        aligmentSixButton.layer.borderColor = Assets.Colors.UnTouch.layerBorder.color.cgColor
        aligmentSixButton.layer.cornerRadius = 25
        aligmentSixButton.layer.borderWidth = 1
        aligmentSixButton.setTitle("6", for: .normal)
        
        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
        aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
        aligmentThreeButton.translatesAutoresizingMaskIntoConstraints = false
        aligmentFourButton.translatesAutoresizingMaskIntoConstraints = false
        aligmentFiveButton.translatesAutoresizingMaskIntoConstraints = false
        aligmentSixButton.translatesAutoresizingMaskIntoConstraints = false
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        } else {
            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        }
        aligmentOneButton.setTitleColor(Assets.Colors.Touch.text.color, for: .normal)
      
        addSubview(aligmentOneButton)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        } else {
            aligmentTwoButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        }
        aligmentTwoButton.setTitleColor(Assets.Colors.UnTouch.text.color, for: .normal)
      
        addSubview(aligmentTwoButton)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        } else {
            aligmentThreeButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        }
        aligmentThreeButton.setTitleColor(Assets.Colors.UnTouch.text.color, for: .normal)
   
        addSubview(aligmentThreeButton)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        } else {
            aligmentFourButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        }
        aligmentFourButton.setTitleColor(Assets.Colors.UnTouch.text.color, for: .normal)
        
        addSubview(aligmentFourButton)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            aligmentFiveButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        } else {
            aligmentFiveButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        }
        aligmentFiveButton.setTitleColor(Assets.Colors.UnTouch.text.color, for: .normal)
   
        addSubview(aligmentFiveButton)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            aligmentSixButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        } else {
            aligmentSixButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        }
        aligmentSixButton.setTitleColor(Assets.Colors.UnTouch.text.color, for: .normal)
     
        addSubview(aligmentSixButton)
        
        NSLayoutConstraint.activate([
            aligmentThreeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 81),
            aligmentThreeButton.trailingAnchor.constraint(equalTo: aligmentThreeButton.leadingAnchor, constant: 68),
            aligmentThreeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 251),
            aligmentThreeButton.bottomAnchor.constraint(equalTo: aligmentThreeButton.topAnchor, constant: 90),
        ])
        NSLayoutConstraint.activate([
            aligmentTwoButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
            aligmentTwoButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 251),
            aligmentTwoButton.bottomAnchor.constraint(equalTo: aligmentThreeButton.topAnchor, constant: 90),
            aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentTwoButton.leadingAnchor, constant: 68),
        ])
        NSLayoutConstraint.activate([
            aligmentOneButton.leadingAnchor.constraint(equalTo: aligmentTwoButton.trailingAnchor, constant: 24),
            aligmentOneButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 251),
            aligmentOneButton.bottomAnchor.constraint(equalTo: aligmentOneButton.topAnchor, constant: 90),
            aligmentOneButton.trailingAnchor.constraint(equalTo: aligmentOneButton.leadingAnchor, constant: 68),
        ])
        NSLayoutConstraint.activate([
            aligmentFiveButton.bottomAnchor.constraint(equalTo: aligmentTwoButton.topAnchor, constant: -24),
            aligmentFiveButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
            aligmentFiveButton.widthAnchor.constraint(equalToConstant: 68),
            aligmentFiveButton.heightAnchor.constraint(equalToConstant: 90),
        ])
        NSLayoutConstraint.activate([
            aligmentFourButton.topAnchor.constraint(equalTo: aligmentTwoButton.bottomAnchor, constant: 24),
            aligmentFourButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
            aligmentFourButton.widthAnchor.constraint(equalToConstant: 68),
            aligmentFourButton.heightAnchor.constraint(equalToConstant: 90),
        ])
        NSLayoutConstraint.activate([
            aligmentSixButton.bottomAnchor.constraint(equalTo: aligmentFiveButton.topAnchor, constant: -24),
            aligmentSixButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: 24),
            aligmentSixButton.widthAnchor.constraint(equalToConstant: 68),
            aligmentSixButton.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
}
