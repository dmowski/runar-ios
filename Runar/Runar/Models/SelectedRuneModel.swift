//
//  SelectedRuneModel.swift
//  Runar
//
//  Created by George Stupakov on 25/05/2022.
//

import UIKit

class SelectedRuneModel {
    
    let title: String
    let image: UIImage
    let index: IndexPath
    let id: String
    
    init(title: String, image: UIImage, index: IndexPath, id: String) {
        self.title = title
        self.image = image
        self.index = index
        self.id = id
    }
}
