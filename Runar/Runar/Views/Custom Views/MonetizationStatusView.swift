//
//  MonetizationStatusView.swift
//  Runar
//
//  Created by George Stupakov on 22/07/2022.
//

import UIKit
import SnapKit

class MonetizationStatusView: UIView {
    
    internal let topChoosedView = UIView()
    private let saleImage = UIImageView()
    internal let titleLabel = UILabel()
    internal let lineUnder = UIView()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let oldPriceLabel = UILabel()
    private let subPriceTitle = UILabel()
    
    private var ifStrikeThroughPrice: Bool = false
    private var ifSaleImage: Bool = false
    
    init(titleLabel: String, descriptionLabel: String, priceLabel: String,
         subPriceTitle: String, strikeThrough: Bool, ifSaleImage: Bool) {
        super.init(frame: .zero)
        self.titleLabel.text = titleLabel
        self.descriptionLabel.text = descriptionLabel
        self.priceLabel.text = priceLabel
        self.subPriceTitle.text = subPriceTitle
        self.ifStrikeThroughPrice = strikeThrough
        self.ifSaleImage = ifSaleImage
        setupBackgroundView()
        setupDescription()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackgroundView() {
        
        layer.cornerRadius = 16
        layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        
        if ifSaleImage == true {
            saleImage.image = Assets.sale50.image
            saleImage.contentMode = .scaleToFill
            saleImage.layer.masksToBounds = true
            saleImage.layer.cornerRadius = 16
            saleImage.layer.maskedCorners = [.layerMinXMaxYCorner]
            addSubview(saleImage)
            saleImage.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(0)
                make.bottom.equalToSuperview().offset(0)
                if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                    make.size.equalTo(40)
                } else {
                    make.size.equalTo(34)
                }
            }
        }
        
        topChoosedView.layer.masksToBounds = true
        topChoosedView.layer.cornerRadius = 16
        topChoosedView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        addSubviews(topChoosedView)
        topChoosedView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().offset(0)
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.height.equalTo(44)
            } else {
                make.height.equalTo(36)
            }
        }
    }
    
    func setupDescription() {
        
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.font = .amaticBold(size: 24)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.top.equalToSuperview().offset(12)
            } else {
                make.top.equalToSuperview().offset(8)
            }
        }
        
        lineUnder.layer.borderWidth = 1.0
        lineUnder.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.3).cgColor
        addSubview(lineUnder)
        lineUnder.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(1)
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
            } else {
                make.top.equalTo(titleLabel.snp.bottom).offset(4)
            }
        }
        
        descriptionLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        descriptionLabel.font = .systemRegular(size: 11)
        descriptionLabel.textAlignment = .center
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.top.equalTo(titleLabel.snp.bottom).offset(17)
            } else {
                make.top.equalTo(titleLabel.snp.bottom).offset(7)
            }
        }
        
        priceLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        priceLabel.font = .systemMedium(size: 28)
        priceLabel.textAlignment = .center
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            } else {
                make.top.equalTo(descriptionLabel.snp.bottom).offset(0)
            }
        }
        
        subPriceTitle.textColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1)
        subPriceTitle.font = .systemRegular(size: 13)
        subPriceTitle.textAlignment = .center
        if ifStrikeThroughPrice == true {
            self.subPriceTitle.attributedText = subPriceTitle.text?.strikeThrough()
        }
        addSubview(subPriceTitle)
        subPriceTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
                make.top.equalTo(priceLabel.snp.bottom).offset(3)
            } else {
                make.top.equalTo(priceLabel.snp.bottom).offset(0)
            }
        }
    }
}
