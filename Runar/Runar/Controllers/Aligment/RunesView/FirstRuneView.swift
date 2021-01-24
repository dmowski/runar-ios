//
//  FirstRunView.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import UIKit

class FirstRuneView: UIView {
    
    private let aligmentOneButton = UIButton()
    
    
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
        
        
        aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        } else {
            aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
        }
        aligmentOneButton.setTitleColor(Assets.Colors.Touch.text.color, for: .normal)
        addSubview(aligmentOneButton)
        
        NSLayoutConstraint.activate([
            aligmentOneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            aligmentOneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            aligmentOneButton.widthAnchor.constraint(equalToConstant: 68),
            aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
}
