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
    
    static let staticCell = "staticCell"
    private var title: String?
    
    init(title: String) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: StaticCell.staticCell)
        
        self.title = title
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
