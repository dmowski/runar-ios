//
//  LibraryTextCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 6/7/21.
//

import UIKit

public class LibraryTextCell: LibraryCell {
    public override func bind(node: LibraryNode) -> Void {
        bindTextLabel(text: node.content, font: UIFont.create(withLowSize: 17, withHighSize: 19))
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
}
