//
//  LibraryPathCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 6/9/21.
//

import UIKit

public class LibraryPathCell: LibraryCell {
    public override func bind(node: LibraryNode) -> Void {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        guard node.type != .core else {
            return
        }
        
        let label = createLabel(for: node)
                       
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: widthAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func createLabel(for node: LibraryNode) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 118, height: 20))
        
        label.textColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 0.65)
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.lineBreakMode = .byTruncatingTail
                
        let titles: [String] = node.getParentTitles()
        
        if (titles.count == 0){
            label.text = "> \(node.title!)"
        } else {
            let header: String = titles.joined(separator: " > ")
            
            let formatedHeader = NSMutableAttributedString(string: "> \(header) > \(titles.count == 1 ? node.title! : "...")")
            formatedHeader.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.659, green: 0.651, blue: 0.639, alpha: 0.38),
                                        range: NSRange(location: 0, length: header.count + 2))
            label.attributedText = formatedHeader
        }
        
        return label
    }
}

private extension LibraryNode {
    func getParentTitles() -> [String] {
        var titles: [String] = []
        
        self.parent!.fillTitles(&titles)
        
        return titles
    }
    
    func fillTitles(_ titles: inout [String]) -> Void{
        guard self.type != .core else {
            return
        }
        
        self.parent!.fillTitles(&titles)
        
        titles.append(self.title!)
    }
}
