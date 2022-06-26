//
//  CustomCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/18/21.
//

import UIKit

public class LibraryCell: UITableViewCell, LibraryCellProtocol {
    
    // MARK: - Props
    public var arrow: UIButton = {
        let arrow = UIButton()
        arrow.setImage(Assets.settingsArrow.image, for: .normal)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcs
    func addArrow() {
        addSubview(arrow)
        
        NSLayoutConstraint.activate([
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            arrow.widthAnchor.constraint(equalToConstant: 8),
            arrow.heightAnchor.constraint(equalToConstant: 14),
            arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func bindTextLabel(text: String?, font: UIFont, color: UIColor? = nil, alignment: NSTextAlignment = .left, contentMode: UIView.ContentMode = .left) -> Void {
        textLabel.bind(text: text, font: font, color: color ?? UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1))
        textLabel?.textAlignment = alignment
        textLabel?.contentMode = contentMode
    }
    
    func bindDetailTextLabel(text: String?, font: UIFont, color: UIColor? = nil, alignment: NSTextAlignment = .left, frame: CGRect = CGRect.zero) -> Void {
        detailTextLabel.bind(text: text, font: font, color: color ?? UIColor(red: 0.569, green: 0.569, blue: 0.569, alpha: 1))
        detailTextLabel?.textAlignment = alignment
    }
    
    func bindImageView(url: String) -> Void {
        imageView?.image = UIImage.create(fromUrl: url)
    }
    
    public func bind(node: LibraryNode) -> Void {
        fatalError("bind method should be overriden!")
    }
}

// MARK: - Extensions
private extension Optional where Wrapped == UILabel {
    func bind(text: String?, font: UIFont, color: UIColor) -> Void {
        self?.font = font
        self?.textColor = color
        self?.contentMode = .scaleToFill
        self?.numberOfLines = 0
        self?.text = text
    }
}

public extension UIFont {
    static func create(withLowSize lowSize: CGFloat, withHighSize highSize: CGFloat) -> UIFont{
        let size = DeviceType.isIPhone678 || DeviceType.iPhoneSE ? lowSize : highSize.heightDependent()
        
        return FontFamily.SFProDisplay.regular.font(size: size)
    }
    
    static func createMedium(withLowSize lowSize: CGFloat, withHighSize highSize: CGFloat) -> UIFont{
        let size = DeviceType.isIPhone678 || DeviceType.iPhoneSE ? lowSize : highSize.heightDependent()
        
        return FontFamily.SFProDisplay.medium.font(size: size)
    }
}
