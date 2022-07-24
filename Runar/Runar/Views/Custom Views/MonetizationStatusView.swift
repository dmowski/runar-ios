//
//  MonetizationStatusView.swift
//  Runar
//
//  Created by George Stupakov on 22/07/2022.
//

import UIKit
import SnapKit

class MonetizationStatusView: UIView {
    
    private let backGroundImage = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let oldPriceLabel = UILabel()
    private let subPriceTitle = UILabel()
    

    init(titleLabel: String, descriptionLabel: String, priceLabel: String, subPriceTitle: String) {
        super.init(frame: .zero)
        self.titleLabel.text = titleLabel
        self.descriptionLabel.text = descriptionLabel
        self.priceLabel.text = priceLabel
        self.subPriceTitle.text = subPriceTitle
        setupBackground()
        setupDescription()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBackground() {
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1).cgColor
        self.snp.makeConstraints { make in
            make.height.equalTo(140)
            make.width.equalTo(110)
        }
    }

    func setupDescription() {

        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.font = FontFamily.AmaticSC.bold.font(size: 24)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(6)
        }

        descriptionLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        descriptionLabel.font = FontFamily.SFProDisplay.medium.font(size: 13)
        descriptionLabel.textAlignment = .center
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
        }

        priceLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        priceLabel.font = FontFamily.SFProDisplay.regular.font(size: 17)
        priceLabel.textAlignment = .center
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
        }
        
        subPriceTitle.textColor = UIColor(red: 1, green: 0.753, blue: 0.275, alpha: 1)
        subPriceTitle.font = FontFamily.SFProDisplay.medium.font(size: 10)
        subPriceTitle.textAlignment = .center
        addSubview(subPriceTitle)
        subPriceTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
        }
    }
    
}
