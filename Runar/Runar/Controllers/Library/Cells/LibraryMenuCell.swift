//
//  LibraryMenuCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 6/7/21.
//

import UIKit

public class LibraryMenuCell: LibraryCell{
    
    //MARK: - Funcs
    public override func bind(node: LibraryNode) -> Void {
        addArrow()
        bindTextLabel(text: node.title, font: UIFont.create(withLowSize: 17, withHighSize: 22))
    }
}
