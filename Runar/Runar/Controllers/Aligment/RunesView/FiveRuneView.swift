//
//  FiveRuneView.swift
//  Runar
//
//  Created by Oleg Kanatov on 24.01.21.
//

import UIKit

class FiveRuneView: UIView {
    
    private let aligmentOneButton = UIButton()
    private let aligmentTwoButton = UIButton()
    private let aligmentThreeButton = UIButton()
    private let aligmentFourButton = UIButton()
    
    
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
        
        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
        aligmentTwoButton.translatesAutoresizingMaskIntoConstraints = false
        aligmentThreeButton.translatesAutoresizingMaskIntoConstraints = false
        aligmentFourButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        NSLayoutConstraint.activate([
            aligmentOneButton.leadingAnchor.constraint(equalTo: aligmentFourButton.trailingAnchor, constant: -68),
            aligmentOneButton.topAnchor.constraint(equalTo: aligmentFourButton.bottomAnchor, constant: 24),
            aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
            aligmentOneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            aligmentTwoButton.trailingAnchor.constraint(equalTo: aligmentThreeButton.leadingAnchor, constant: -116),
            aligmentTwoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            aligmentTwoButton.widthAnchor.constraint(equalToConstant: 68),
            aligmentTwoButton.heightAnchor.constraint(equalToConstant: 90),
        ])
        NSLayoutConstraint.activate([
            aligmentThreeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -81),
            aligmentThreeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            aligmentThreeButton.leadingAnchor.constraint(equalTo: aligmentThreeButton.trailingAnchor, constant: -68),
            aligmentThreeButton.heightAnchor.constraint(equalToConstant: 90),
        ])
        NSLayoutConstraint.activate([
            aligmentFourButton.leadingAnchor.constraint(equalTo: aligmentFourButton.trailingAnchor, constant: -68),
            aligmentFourButton.bottomAnchor.constraint(equalTo: aligmentFourButton.topAnchor, constant: 90),
            aligmentFourButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 194),
            aligmentFourButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
    }
}
