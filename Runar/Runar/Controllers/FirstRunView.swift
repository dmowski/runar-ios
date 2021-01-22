//
//  FirstRunView.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import UIKit

class FirstRunView: UIView {

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
        aligmentOneButton.backgroundColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 0.35)
               aligmentOneButton.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.7).cgColor
               aligmentOneButton.layer.cornerRadius = 25
               aligmentOneButton.layer.borderWidth = 1
               aligmentOneButton.setTitle("1", for: .normal)
       
       
               aligmentOneButton.translatesAutoresizingMaskIntoConstraints = false
               if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
                   aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
               } else {
                   aligmentOneButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: 50)
               }
               aligmentOneButton.setTitleColor(UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36), for: .normal)
               aligmentOneButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
               addSubview(aligmentOneButton)
       
                   NSLayoutConstraint.activate([
                       aligmentOneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                       aligmentOneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                       aligmentOneButton.widthAnchor.constraint(equalToConstant: 68),
                       aligmentOneButton.heightAnchor.constraint(equalToConstant: 90),
                   ])
    }
}
