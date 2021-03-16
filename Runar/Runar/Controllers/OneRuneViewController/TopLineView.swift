//
//  TopLineView.swift
//  Runar
//
//  Created by Юлия Лопатина on 14.03.21.
//

import UIKit

protocol Closable {
    func closePopUp()
}

final class TopLineView: UIView {
    
    var delegate: Closable?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addBlackView()
        configureNameConstr()
        configureTimeConstr()
        configureLuckConstr()
        setUpCloseConstr()
    }
    
    convenience init(runeType: RuneType, runeTime: String) {
        self.init(frame: .zero)
        let nameParagraphStyle = NSMutableParagraphStyle()
        nameParagraphStyle.lineHeightMultiple = 0.87
        runeNameLabel.attributedText = NSMutableAttributedString(string: "runeType.name", attributes: [NSAttributedString.Key.paragraphStyle: nameParagraphStyle])
        let timeParagraphStyle = NSMutableParagraphStyle()
        timeParagraphStyle.lineHeightMultiple = 1.4
        timeLabel.attributedText = NSMutableAttributedString(string: runeTime, attributes: [NSAttributedString.Key.paragraphStyle: timeParagraphStyle])
        luckLevelLabel.attributedText = NSMutableAttributedString(string: String(runeType.luck), attributes: [NSAttributedString.Key.paragraphStyle: timeParagraphStyle])
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
        label.font = UIFont(name: "SFProDisplay-Regular", size: 24.heightDependent())
        label.sizeToFit()
        return label
    }()
    
    private func configureNameConstr() {
        self.addSubview(runeNameLabel)
        NSLayoutConstraint.activate([
            runeNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 37.heightDependent()),
            runeNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            runeNameLabel.bottomAnchor.constraint(equalTo: runeNameLabel.topAnchor, constant: 25.heightDependent())
        ])
    }
    
    //MARK: - TimeLabel
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.659, green: 0.651, blue: 0.639, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 15.heightDependent())
        label.sizeToFit()
        return label
    }()
    
    private func configureTimeConstr() {
        self.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: runeNameLabel.bottomAnchor, constant: 5.heightDependent()),
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 25.heightDependent())
        ])
    }
    
    //MARK: - LuckLabel
    
    private var luckLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        label.sizeToFit()
        return label
    }()
    
    private func configureLuckConstr() {
        self.addSubview(luckLevelLabel)
        NSLayoutConstraint.activate([
            luckLevelLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5.heightDependent()),
            luckLevelLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            luckLevelLabel.heightAnchor.constraint(equalToConstant: 29.heightDependent())
        ])
    }
    
    //MARK: - CloseButton
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.escape.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonOnClose), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonOnClose() {
        delegate?.closePopUp()
    }
    
    private func setUpCloseConstr() {
        self.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.heightDependent()),
            closeButton.heightAnchor.constraint(equalToConstant: 48.heightDependent()),
            closeButton.widthAnchor.constraint(equalToConstant: 48.heightDependent()),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.heightDependent())
        ])
    }
}
