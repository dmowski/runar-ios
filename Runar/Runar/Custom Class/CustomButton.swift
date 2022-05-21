//
//  CustomButton.swift
//  Runar
//
//  Created by Oleg Kanatov on 30.03.21.
//

import UIKit

class CustomButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                self.backgroundColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
                self.layer.borderColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1).cgColor
            } else {
                self.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
                self.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
            }
        }
    }
}
