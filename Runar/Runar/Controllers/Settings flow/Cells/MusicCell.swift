//
//  MusicCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension String {
    static let music = L10n.Tabbar.music
}

extension UIColor {
    static let musicIsOn = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
    static let musicIsOf = UIColor(red: 0.604, green: 0.604, blue: 0.604, alpha: 1)
}

class MusicCell: UITableViewCell {
    
    private let musicPlayer = MusicViewController.shared.audioPlayer
    
    static let identifier = "MusicCell"
    
    private var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = .musicIsOn
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.tag = 200
        return switchControl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        switchControl.addTarget(self, action: #selector(switchOnTap), for: .valueChanged)
        
        let fontSize = DeviceType.isIPhone678 || DeviceType.iPhoneSE ? 17 : 20.heightDependent()
        textLabel?.font = .systemRegular(size: fontSize)
        textLabel?.textColor = .settingsWhiteText
        
        configureUI()
        checkPlayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(switchControl)
        NSLayoutConstraint.activate([switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                                     switchControl.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
    
    private func checkPlayer() {
        if !UserDefaults.standard.bool(forKey: "is_off_music") {
            switchControl.isOn = true
        } else {
            switchControl.isOn = false
        }
    }
    
    @objc private func switchOnTap(_ sender: UISwitch) {
        if sender.tag == 200 {
        if !switchControl.isOn {
            MusicViewController.shared.stopBackgroundMusic()
            UserDefaults.standard.set(true, forKey: "is_off_music")
        } else {
            if musicPlayer?.isPlaying != nil {
                MusicViewController.shared.playBackgroundMusic()
            } else {
                MusicViewController.shared.initBackgroundMusic()
                MusicViewController.shared.playBackgroundMusic()
            }
            UserDefaults.standard.set(false, forKey: "is_off_music")
        }}
    }
}
