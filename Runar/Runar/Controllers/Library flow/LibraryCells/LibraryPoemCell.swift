//
//  LibraryPoemCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 6/7/21.
//

import UIKit

public class LibraryPoemCell: LibraryCell {
    
    // MARK: - Funcs
    public override func bind(node: LibraryNode) -> Void {
        
        bindTextLabel(text: node.title,
                      font: UIFont.create(withLowSize: 20, withHighSize: 24),
                      color: UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 1),
                      alignment: .center)
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel!.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel!.widthAnchor.constraint(equalToConstant: 70),
            textLabel!.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        bindDetailTextLabel(text: node.content, font: UIFont.create(withLowSize: 17, withHighSize: 19), alignment: .center)
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.lineBreakMode = .byWordWrapping
        detailTextLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailTextLabel!.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailTextLabel!.leftAnchor.constraint(equalTo: leftAnchor),
            detailTextLabel!.rightAnchor.constraint(equalTo: rightAnchor),
            detailTextLabel!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -29),
            detailTextLabel!.topAnchor.constraint(equalTo: textLabel!.bottomAnchor)
        ])
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
}
