//
//  LibraryRootCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 6/7/21.
//

import UIKit

public class LibraryRootCell: LibraryCell {
    
    // MARK: - Funcs
    public override func bind(node: LibraryNode) -> Void {
        addArrow()
        bindTextLabel(text: node.title, font: UIFont.create(withLowSize: 20, withHighSize: 26))
        bindDetailTextLabel(text: node.content, font: UIFont.create(withLowSize: 13, withHighSize: 17), frame: CGRect.create())
        bindImageView(url: node.imageUrl!)
    }
}

// MARK: - Fxtensions
private extension CGRect {
    static func create() -> CGRect {
       return CGRect(x: 0, y: 0, width: 256, height: 36)
    }
}
