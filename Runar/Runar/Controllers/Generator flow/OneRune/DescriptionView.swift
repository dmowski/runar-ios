//
//  DescriptionView.swift
//  Runar
//
//  Created by Юлия Лопатина on 21.03.21.
//

import UIKit

class DescriptionView: UIView {
    
    private var scrollViewDescription = UIScrollView()
    private var runeType: RuneType?

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setUpScrollViewDescription()
        setUpDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(runeType: RuneType) {
        self.init(frame: .zero)
        
        self.runeType = runeType
        let timeParagraphStyle = NSMutableParagraphStyle()
        timeParagraphStyle.lineHeightMultiple = 1.23
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 16 : 19
        let atributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemLight(size: fontSize),
            .foregroundColor: UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1),
            .paragraphStyle: timeParagraphStyle,
            .kern: -0.38,
        ]
        descriptionLabel.attributedText = NSMutableAttributedString(string: runeType.description, attributes: atributes)
    }

    private func setUpScrollViewDescription() {
        scrollViewDescription.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(scrollViewDescription)
        
        scrollViewDescription.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalToSuperview()
        }
    }

    private func setUpDescriptionLabel() {
        scrollViewDescription.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.width.bottom.centerX.equalTo(scrollViewDescription)
        }
    }
}
