//
//  CustomCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/18/21.
//

import UIKit

public class LibraryNodeCell: UITableViewCell {
    public var arrow: UIButton = {
        let arrow = UIButton()
        arrow.setImage(Assets.settingsArrow.image, for: .normal)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addArrow(){
        addSubview(arrow)
        
        NSLayoutConstraint.activate([
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            arrow.widthAnchor.constraint(equalToConstant: 8),
            arrow.heightAnchor.constraint(equalToConstant: 14),
            arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func bindTextLabel(text: String?, font: UIFont) -> Void {
        let color = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        textLabel.bind(text: text, font: font, color: color)
    }
    
    func bindDetailTextLabel(text: String?, font: UIFont) -> Void {
        let color = UIColor(red: 235, green: 235, blue: 245, alpha: 0.6)
        detailTextLabel.bind(text: text, font: font, color: color)
    }
    
    func bindImageView(url: String) -> Void {
        imageView?.image = UIImage.create(fromUrl: url)
    }
    
    func bind(node: LibraryNode) -> Void {
        switch node.type {
        case .root:
            addArrow()
            bindTextLabel(text: node.title, font: UIFont.create(withLowSize: 17, withHighSize: 20))
            bindDetailTextLabel(text: node.content, font: UIFont.create(withLowSize: 15, withHighSize: 16))
            bindImageView(url: node.imageUrl!)
            break
        case .text:
            bindTextLabel(text: node.content, font: UIFont.create(withLowSize: 17, withHighSize: 19))
            self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        default:
            addArrow()
            bindTextLabel(text: node.title, font: UIFont.create(withLowSize: 17, withHighSize: 20))
        }
    }
}

private extension UIImage {
    static func create(fromUrl url: String) -> UIImage? {
        let imageUrl: URL = URL(string: url)!
        let imageData =  try! Data(contentsOf: imageUrl)
        
        return UIImage(data: imageData)
    }
}

private extension Optional where Wrapped == UILabel {
    func bind(text: String?, font: UIFont, color: UIColor) -> Void {
        self?.font = font
        self?.textColor = color
        self?.contentMode = .scaleToFill
        self?.numberOfLines = 0
        self?.text = text
    }
}

private extension UIFont {
    static func create(withLowSize lowSize: CGFloat, withHighSize highSize: CGFloat) -> UIFont{
        let size = DeviceType.isIPhone678 || DeviceType.iPhoneSE ? lowSize : highSize.heightDependent()
        
        return FontFamily.SFProDisplay.regular.font(size: size)
    }
}
