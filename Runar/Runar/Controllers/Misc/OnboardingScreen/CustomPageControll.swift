//
//  CustomPageControll.swift
//  Runar
//
//  Created by Виталий Татун on 17.11.22.
//

import UIKit

class CustomPageControll: UIButton {
    
    var numberOfDots: Int = 0
    var currentPage: Int = 0
    
    func setUpIndicator(size: CGFloat, indicatorColor: UIColor, image systemName: String) {
        let configuration = UIImage.SymbolConfiguration(pointSize: size)
        setImage(UIImage(systemName: systemName, withConfiguration: configuration), for: .normal)
        tintColor = indicatorColor
    }
}
