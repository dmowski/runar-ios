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
        
        bindTextLabel(text: node.title, font: UIFont.createMedium(withLowSize: 22, withHighSize: 22))
        textLabel?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(102)
            make.top.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-56)
            make.bottom.equalToSuperview().offset(-58)
        })
        
        bindDetailTextLabel(text: node.content, font: UIFont.create(withLowSize: 13, withHighSize: 13), frame: CGRect.create())
        detailTextLabel?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(102)
            make.top.equalToSuperview().offset(58)
            make.trailing.equalToSuperview().offset(-56)
            make.bottom.equalToSuperview().offset(-19)
        })

        bindImageView(url: node.imageUrl!)
        imageView?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(26)
            make.bottom.equalToSuperview().offset(-16)
            make.height.width.equalTo(70)
        })
    }
}

// MARK: - Fxtensions
private extension CGRect {
    static func create() -> CGRect {
       return CGRect(x: 0, y: 0, width: 150, height: 36)
    }
}
