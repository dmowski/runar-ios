//
//  TopLineView.swift
//  Runar
//
//  Created by Юлия Лопатина on 14.03.21.
//

import UIKit

final class TopLineView: UIView {
    
    // MARK: Constants
    let nameLabelTopAnchor = 37
    let timeLabelTopAnchor = 5
    let timeLabeltrailingLeadingAnchor = 24
    let luckLabelTopAnchor = 2
    let luckLabeltrailingLeadingAnchor = 24
    let LuckLabelBottomAnchor = 15
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addBlackView()
        configureNameConstraints()
        configureTimeConstraints()
        configureLuckLabelConstraints()
    }
    
    convenience init(runeType: RuneType, runeTime: String, luck: String) {
        self.init(frame: .zero)
        let nameParagraphStyle = NSMutableParagraphStyle()
        nameParagraphStyle.lineHeightMultiple = 0.87
        runeNameLabel.attributedText = NSMutableAttributedString(string: String(runeType.name), attributes: [NSAttributedString.Key.paragraphStyle: nameParagraphStyle])
        let timeParagraphStyle = NSMutableParagraphStyle()
        timeParagraphStyle.lineHeightMultiple = 1.4
        timeParagraphStyle.alignment = .center
        timeLabel.attributedText = NSMutableAttributedString(string: runeTime, attributes: [NSAttributedString.Key.paragraphStyle: timeParagraphStyle])
        let luckParagraphStyle = NSMutableParagraphStyle()
        luckParagraphStyle.lineHeightMultiple = 1.12
        luckParagraphStyle.alignment = .center
        luckLabel.attributedText = NSMutableAttributedString(string: luck, attributes: [NSAttributedString.Key.paragraphStyle: luckParagraphStyle])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -BlackView
    private var blackView: UIImageView = {
        let blackView = UIImageView()
        blackView.image = Assets.Background.topBlackGradient.image
        blackView.translatesAutoresizingMaskIntoConstraints = false
        return blackView
    }()
    
    private func addBlackView() {
        self.addSubview(blackView)
        blackView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    //MARK: - NameLabel
    private var runeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .yellowPrimaryColor
        let nameHeight: CGFloat = DeviceType.iPhoneSE || DeviceType.isIPhone678 ? 17 : 24
        label.font = .systemRegular(size: nameHeight)
        label.sizeToFit()
        return label
    }()
    
    private func configureNameConstraints() {
        self.addSubview(runeNameLabel)
        runeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabelTopAnchor)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - TimeLabel
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .disabledTextColor
        label.numberOfLines = 0
        let labelHeight: CGFloat = 15
        label.font = .systemRegular(size: labelHeight)
        label.sizeToFit()
        return label
    }()
    
    private func configureTimeConstraints() {
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(runeNameLabel.snp.bottom).offset(timeLabelTopAnchor)
            make.trailing.leading.equalToSuperview().inset(timeLabeltrailingLeadingAnchor)
        }
    }
    
    private var luckLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .iconNeutralsGreyColor
        label.numberOfLines = 0
        let labelHeight: CGFloat = 15
        label.font = .systemRegular(size: labelHeight)
        return label
    }()
    
    private func configureLuckLabelConstraints() {
        self.addSubview(luckLabel)
        luckLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(luckLabelTopAnchor)
            make.trailing.leading.equalToSuperview().inset(luckLabeltrailingLeadingAnchor)
            make.bottom.equalToSuperview().inset(LuckLabelBottomAnchor)
        }
    }
}
