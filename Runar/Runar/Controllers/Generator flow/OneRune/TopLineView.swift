//
//  TopLineView.swift
//  Runar
//
//  Created by Юлия Лопатина on 14.03.21.
//

import UIKit

final class TopLineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addBlackView()
        configureNameConstr()
        configureTimeConstr()
        configureLuckConstr()
    }
    
    convenience init(runeType: RuneType, runeTime: String) {
        self.init(frame: .zero)
        let nameParagraphStyle = NSMutableParagraphStyle()
        nameParagraphStyle.lineHeightMultiple = 0.87
        runeNameLabel.attributedText = NSMutableAttributedString(string: String(runeType.name), attributes: [NSAttributedString.Key.paragraphStyle: nameParagraphStyle])
        let timeParagraphStyle = NSMutableParagraphStyle()
        timeParagraphStyle.lineHeightMultiple = 1.4
        timeLabel.attributedText = NSMutableAttributedString(string: runeTime, attributes: [NSAttributedString.Key.paragraphStyle: timeParagraphStyle])
        luckLevelLabel.attributedText = NSMutableAttributedString(string: runeType.luck.getLuckyLevelString(), attributes: [NSAttributedString.Key.paragraphStyle: timeParagraphStyle])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -BlackView
    private var blackView: UIImageView = {
        let blackView = UIImageView()
        blackView.image = UIImage(named: "topBlackGradient")
        blackView.translatesAutoresizingMaskIntoConstraints = false
        return blackView
    }()
    
    private func addBlackView() {
        self.addSubview(blackView)
        NSLayoutConstraint.activate([
            blackView.topAnchor.constraint(equalTo: self.topAnchor),
            blackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    //MARK: - NameLabel
    private var runeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        let nameHeight: CGFloat = DeviceType.iPhoneSE || DeviceType.isIPhone678 ? 17 : 24
        label.font = UIFont(name: "SFProDisplay-Regular", size: nameHeight)
        label.sizeToFit()
        return label
    }()
    
    private func configureNameConstr() {
        self.addSubview(runeNameLabel)
        NSLayoutConstraint.activate([
            runeNameLabel.topAnchor.constraint(equalTo:topAnchor, constant: 37.heightDependent()),
            runeNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    //MARK: - TimeLabel
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.659, green: 0.651, blue: 0.639, alpha: 1)
        let labelHeight: CGFloat = DeviceType.iPhoneSE || DeviceType.isIPhone678 ? 14 : 15
        label.font = UIFont(name: "SFProDisplay-Regular", size: labelHeight)
        label.sizeToFit()
        return label
    }()
    
    private func configureTimeConstr() {
        self.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: runeNameLabel.bottomAnchor, constant: 5.heightDependent()),
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    //MARK: - LuckLabel
    private var luckLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private func configureLuckConstr() {
        self.addSubview(luckLevelLabel)
        NSLayoutConstraint.activate([
            luckLevelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            luckLevelLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            luckLevelLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            luckLevelLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
