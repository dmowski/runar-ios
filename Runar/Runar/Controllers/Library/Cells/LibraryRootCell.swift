//
//  LibraryRootCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 6/7/21.
//

import UIKit

public class LibraryRootCell: LibraryCell {
    public override func bind(node: LibraryNode) -> Void {
        addArrow()
        bindTextLabel(text: node.title, font: UIFont.create(withLowSize: 17, withHighSize: 22))
        bindDetailTextLabel(text: node.content, font: UIFont.create(withLowSize: 11, withHighSize: 13), frame: CGRect.create())
        bindImageView(url: node.imageUrl!)
    }
}

private extension CGRect {
    static func create() -> CGRect{
       return CGRect(x: 0, y: 0, width: 156, height: 36)
    }
}
