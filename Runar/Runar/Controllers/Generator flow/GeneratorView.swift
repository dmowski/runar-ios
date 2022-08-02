//
//  GeneratorView.swift
//  Runar
//
//  Created by George Stupakov on 01/08/2022.
//

import UIKit
import SnapKit

protocol GeneratorViewDelegateProtocol: AnyObject {
    
    func didTapWithoutPopUp()
    func didTapShowFormulaPopupTap()
    func didTapShowStavesPopupTap()
}

class GeneratorView: UIView {
    
    private let runicPatternView = UIControl()
    private let runicPatternLabel = UILabel()
    private let runicPatternImageView = UIImageView()
    
    private let commingSoonLabel = UILabel()
    
    private let formulaView = UIControl()
    private let formulaLabel = UILabel()
    private let formulaImageView = UIImageView()
    
    private let stavesView = UIControl()
    private let stavesLabel = UILabel()
    private let stavesImageView = UIImageView()
    
    weak var delegate: GeneratorViewDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        RunarLayout.initBackground(for: self, with: .mainFire)
        
        configureRunicPatternView()
        configureCommingSoonLabel()
        configureFormulaView()
        configureStavesView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRunicPatternView() {
        
        runicPatternView.clipsToBounds = true
        runicPatternView.layer.cornerRadius = 16
        runicPatternView.layer.borderWidth = 1
        runicPatternView.contentMode = .center
        runicPatternView.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.6).cgColor
        runicPatternView.layer.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 0.35).cgColor
        runicPatternView.addTarget(self, action: #selector(withoutPopUp), for: .touchUpInside)
        addSubview(runicPatternView)
        runicPatternView.snp.makeConstraints { make in
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                make.topMargin.equalToSuperview().offset(52)
                make.leading.equalToSuperview().offset(36)
                make.trailing.equalToSuperview().offset(-36)
                make.height.equalTo(self).multipliedBy(0.28)
            } else {
                make.topMargin.equalToSuperview().offset(32)
                make.leading.equalToSuperview().offset(27)
                make.trailing.equalToSuperview().offset(-27)
                make.height.equalTo(self).multipliedBy(0.32)
            }
        }
        
        runicPatternLabel.font = FontFamily.AmaticSC.bold.font(size: 36)
        runicPatternLabel.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        runicPatternLabel.textAlignment = .center
        let prgph = NSMutableParagraphStyle()
        prgph.lineHeightMultiple = 0.7
        runicPatternLabel.attributedText = NSMutableAttributedString(string: L10n.Generator.RunePattern.title,
                                                                     attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        runicPatternView.addSubviews(runicPatternLabel)
        runicPatternLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(42)
        }

        runicPatternImageView.contentMode = .scaleAspectFit
        runicPatternImageView.image = Assets.runePattern.image
        runicPatternView.addSubviews(runicPatternImageView)
        runicPatternImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(runicPatternLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureCommingSoonLabel() {
        
        commingSoonLabel.font = FontFamily.AmaticSC.bold.font(size: 24)
        commingSoonLabel.textColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        commingSoonLabel.textAlignment = .center
        commingSoonLabel.contentMode = .center
        let prgph = NSMutableParagraphStyle()
        prgph.lineHeightMultiple = 0.79
        commingSoonLabel.attributedText = NSMutableAttributedString(string: L10n.Generator.commingSoon,
                                                                    attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        addSubviews(commingSoonLabel)
        commingSoonLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                make.top.equalTo(runicPatternView.snp.bottom).offset(38)
            } else {
                make.top.equalTo(runicPatternView.snp.bottom).offset(28)
            }
            make.height.equalTo(24)
        }
    }
    
    private func configureFormulaView() {
        
        formulaView.clipsToBounds = true
        formulaView.layer.cornerRadius = 16
        formulaView.layer.borderWidth = 1
        formulaView.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.6).cgColor
        formulaView.layer.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 0.35).cgColor
        formulaView.addTarget(self, action: #selector(self.showFormulaPopupTap), for: .touchUpInside)
        addSubviews(formulaView)
        formulaView.snp.makeConstraints { make in
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                make.top.equalTo(commingSoonLabel.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(107)
                make.trailing.equalToSuperview().offset(-107)
                make.height.equalTo(self).multipliedBy(0.13)
            } else {
                make.top.equalTo(commingSoonLabel.snp.bottom).offset(7)
                make.leading.equalToSuperview().offset(80)
                make.trailing.equalToSuperview().offset(-80)
                make.height.equalTo(self).multipliedBy(0.17)
            }
        }
        
        formulaLabel.font = FontFamily.AmaticSC.bold.font(size: 20)
        formulaLabel.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        formulaLabel.textAlignment = .center
        formulaLabel.contentMode = .center
        let prgph = NSMutableParagraphStyle()
        prgph.lineHeightMultiple = 1.19
        formulaLabel.attributedText = NSMutableAttributedString(string: L10n.Generator.RuneFormula.title,
                                                                attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        formulaView.addSubviews(formulaLabel)
        formulaLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(20)
        }
        
        formulaImageView.contentMode = .scaleAspectFit
        formulaImageView.image = Assets.runeFormula.image
        formulaView.addSubviews(formulaImageView)
        formulaImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(formulaLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureStavesView() {
        
        stavesView.clipsToBounds = true
        stavesView.layer.cornerRadius = 16
        stavesView.layer.borderWidth = 1
        stavesView.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.6).cgColor
        stavesView.layer.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 0.35).cgColor
        stavesView.addTarget(self, action: #selector(self.showStavesPopupTap), for: .touchUpInside)
        addSubviews(stavesView)
        stavesView.snp.makeConstraints { make in
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                make.top.equalTo(formulaView.snp.bottom).offset(18)
                make.leading.equalToSuperview().offset(107)
                make.trailing.equalToSuperview().offset(-107)
                make.height.equalTo(self).multipliedBy(0.13)
            } else {
                make.top.equalTo(formulaView.snp.bottom).offset(12)
                make.leading.equalToSuperview().offset(80)
                make.trailing.equalToSuperview().offset(-80)
                make.height.equalTo(self).multipliedBy(0.17)
            }
        }
        
        stavesLabel.font = FontFamily.AmaticSC.bold.font(size: 20)
        stavesLabel.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        stavesLabel.textAlignment = .center
        stavesLabel.contentMode = .center
        let prgph = NSMutableParagraphStyle()
        prgph.lineHeightMultiple = 1.19
        stavesLabel.attributedText = NSMutableAttributedString(string: L10n.Generator.RuneStaves.title,
                                                               attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        stavesView.addSubviews(stavesLabel)
        stavesLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(20)
        }
        
        stavesImageView.contentMode = .scaleAspectFit
        stavesImageView.image = Assets.runeStaves.image
        stavesView.addSubviews(stavesImageView)
        stavesImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stavesLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func withoutPopUp() {
        delegate?.didTapWithoutPopUp()
    }

    @objc private func showFormulaPopupTap() {
        delegate?.didTapShowFormulaPopupTap()
    }
    
    @objc private func showStavesPopupTap() {
        delegate?.didTapShowStavesPopupTap()
    }
}
