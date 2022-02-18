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
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            arrow.widthAnchor.constraint(equalToConstant: 8),
            arrow.heightAnchor.constraint(equalToConstant: 14),
            arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func bindTextLabel(text: String?, font: UIFont, color: UIColor? = nil, alignment: NSTextAlignment = .left, contentMode: UIView.ContentMode = .left) -> Void {
        textLabel.bind(text: text, font: font, color: color ?? UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1))
        textLabel?.textAlignment = alignment
        textLabel?.contentMode = contentMode
    }
    
    func bindDetailTextLabel(text: String?, font: UIFont, color: UIColor? = nil, alignment: NSTextAlignment = .left, frame: CGRect = CGRect.zero) -> Void {
        detailTextLabel.bind(text: text, font: font, color: color ?? UIColor(red: 235, green: 235, blue: 245, alpha: 0.6))
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
public extension UIImage {
    static func create(fromUrl url: String) -> UIImage? {
        let imageData: Data = RunarApi.getData(byUrl: url)!
        
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

public extension UIFont {
    static func create(withLowSize lowSize: CGFloat, withHighSize highSize: CGFloat) -> UIFont{
        let size = DeviceType.isIPhone678 || DeviceType.iPhoneSE ? lowSize : highSize.heightDependent()
        
        return FontFamily.SFProDisplay.regular.font(size: size)
    }
}
