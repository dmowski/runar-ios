//
//  MusicCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension String {
    static let music = "Музыка"
}

extension UIColor {
    static let musicIsOn = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
}

class MusicCell: UITableViewCell {
    
    static let musicCell = "musicCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private let musicPlayer = MusicViewController.shared.audioPlayer
    private var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.thumbTintColor = UIColor.musicIsOn
        switchControl.addTarget(self, action: #selector(switchOnTap), for: .valueChanged)
        return switchControl
    }()

    private func configureUI() {
        addSubview(switchControl)
        
        NSLayoutConstraint.activate([
            switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            switchControl.widthAnchor.constraint(equalToConstant: 36),
            switchControl.heightAnchor.constraint(equalToConstant: 20),
            switchControl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        )
    }
    
    private func checkPlayer() {
        if ((musicPlayer?.isPlaying) != nil) {
            switchControl.isOn = true
        } else {
            switchControl.isOn = false
        }
    }
    
    @objc private func switchOnTap() {
        if switchControl.isOn {
            musicPlayer?.stop()
        } else {
            musicPlayer?.play()
        }
    }
}
