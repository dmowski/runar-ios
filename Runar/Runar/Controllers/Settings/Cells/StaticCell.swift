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
    
    static let identifier = "StaticCell"
    private var title: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = FontFamily.SFProDisplay.regular.font(size: 20)
        textLabel?.textColor = .settingsWhiteText
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = Assets.settingsArrow.image
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    private func configureUI() {
        textLabel?.text = title
        addSubview(arrow)
        
        NSLayoutConstraint.activate([
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            arrow.widthAnchor.constraint(equalToConstant: 8),
            arrow.heightAnchor.constraint(equalToConstant: 14),
            arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

}
