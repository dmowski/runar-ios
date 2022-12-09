//
//  MainCellModel.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import UIKit


public class MainCellModel {
    public let runeId: String
    public let name: String
    public let image: UIImage
    
    public init (runeId: String, name: String, image: UIImage) {
        self.runeId = runeId
        self.name = name
        self.image = image
    }
    
}
