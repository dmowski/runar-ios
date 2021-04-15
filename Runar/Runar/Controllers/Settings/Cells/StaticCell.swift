//
//  StaticCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension String {
    static let rateApp = "Оценить приложение"
    static let aboutApp = "О приложении"
}

class StaticCell: UITableViewCell {
    
    var openVC: (()->())?
    static let identifier = "StaticCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        arrow.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        
        let fontSize = DeviceType.isIPhone678 || DeviceType.iPhoneSE ? 17 : 20.heightDependent()
        textLabel?.font = FontFamily.SFProDisplay.regular.font(size: fontSize)
        textLabel?.textColor = .settingsWhiteText
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var arrow: UIButton = {
        let arrow = UIButton()
        arrow.setImage(Assets.settingsArrow.image, for: .normal)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(arrow)
        
        NSLayoutConstraint.activate([
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            arrow.widthAnchor.constraint(equalToConstant: 8),
            arrow.heightAnchor.constraint(equalToConstant: 14),
            arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    @objc private func openLink() {
        guard let openVC = openVC else {return}
        openVC()
    }

}
