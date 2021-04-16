//
//  Interperitation+Ext.swift
//  Runar
//
//  Created by Юлия Лопатина on 5.03.21.
//

import UIKit

extension String {
    static let saveResult = L10n.saveResult
    static let complete = L10n.complete
}

extension AlignmentViewController {
    
    //-------------------------------------------------
    // MARK: - After advertising
    //-------------------------------------------------
    
    func setUpContentAfterAdvertising() {
        scrollViewAlignment.isScrollEnabled = true
        
        showButton.removeFromSuperview()
        startButton.removeFromSuperview()
        escapeButton.removeFromSuperview()
        nameLabel.removeFromSuperview()
        
        removeConstant()
        setUpContentInterpretationView()
        setUpNameLabel()
        setUpLuckLevelLabel()
        setUpDividingLine()
        setUpDescriptionLabel()
        setUpAffirmationLabel()
        setUpCancel()
//        setUpCheckBox()
//        setUpCheckLabel()
//        setUpCheckStack()
    }
    
    
    func removeConstant() {
        runesViewContainer.removeFromSuperview()
        runesViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(runesViewContainer)
        containerTopAnchor = runesViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 162)
        containerTopAnchor!.isActive = true
        NSLayoutConstraint.activate([
            runesViewContainer.centerXAnchor.constraint(equalTo: scrollViewAlignment.centerXAnchor),
            runesViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            runesViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
    
    func setUpContentInterpretationView() {
        
        contentInterpretationView.layer.contents = UIImage(asset: Assets.interpretationBackground)?.cgImage
        contentInterpretationView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentInterpretationView)
        
        NSLayoutConstraint.activate([
            contentInterpretationView.topAnchor.constraint(equalTo: runesViewContainer.bottomAnchor),
            contentInterpretationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentInterpretationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentInterpretationView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
        ])
    }
    
    // MARK: - Luck Label
    
    func setUpLuckLevelLabel() {
        switch runesViewContainer.runeLayout {
        case .dayRune:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            totalLuck = runesViewContainer.runesSet[0].luck
            luckLevelLabel.text = L10n.luckLevel((String(totalLuck)))
        case .twoRunes:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[0].luck
            let luck2 = runesViewContainer.runesSet[1].luck
            totalLuck = (luck1 + luck2)/2
            luckLevelLabel.text = L10n.luckLevel((String(totalLuck)))
        case .norns:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            totalLuck = runesViewContainer.runesSet[2].luck
            luckLevelLabel.text = L10n.luckLevel((String(totalLuck)))
        case .shortPrediction:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[3].luck
            totalLuck = (luck1 + luck2)/2
            luckLevelLabel.text = L10n.luckLevel((String(totalLuck)))
        case .thorsHummer:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[1].luck
            let luck2 = runesViewContainer.runesSet[2].luck
            let luck3 = runesViewContainer.runesSet[3].luck
            totalLuck = (luck1 + luck2 + luck3)/3
            luckLevelLabel.text = L10n.luckLevel((String(totalLuck)))
        case .cross:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[3].luck
            let luck3 = runesViewContainer.runesSet[4].luck
            totalLuck = (luck1 + luck2 + luck3)/3
            luckLevelLabel.text = L10n.luckLevel((String(totalLuck)))
        case .elementsCross:
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[4].luck
            let luck3 = runesViewContainer.runesSet[5].luck
            totalLuck = (luck1 + luck2 + luck3)/3
            luckLevelLabel.text = L10n.luckLevel((String(totalLuck)))
        case .keltsCross:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[4].luck
            let luck3 = runesViewContainer.runesSet[5].luck
            let luck4 = runesViewContainer.runesSet[5].luck
            totalLuck = (luck1 + luck2 + luck3 + luck4)/4
            luckLevelLabel.text = L10n.luckLevel((String(totalLuck)))
        }
        
        luckLevelLabel.font = FontFamily.SFProDisplay.light.font(size: 19)
        luckLevelLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        luckLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(luckLevelLabel)
        NSLayoutConstraint.activate([
            luckLevelLabel.topAnchor.constraint(equalTo: contentInterpretationView.topAnchor, constant: 76),
            luckLevelLabel.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24),
            luckLevelLabel.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor,constant: -24),
        ])
    }
    
    func setUpDividingLine() {
        dividingLine.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.3)
        dividingLine.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(dividingLine)
        
        NSLayoutConstraint.activate([
            dividingLine.topAnchor.constraint(equalTo: luckLevelLabel.bottomAnchor, constant: 27),
            dividingLine.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24),
            dividingLine.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor, constant: -24),
            dividingLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
    
    // MARK: - DescriptionLabel
    
    func setUpDescriptionLabel() {
        var descriptionLabelString = String()
        
        switch runesViewContainer.runeLayout {
        case .dayRune:
            descriptionLabelString = runesViewContainer.runesSet[0].description
        case .twoRunes:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let description = firstRune.cross(runeType: secondRune)
            descriptionLabelString = L10n.InterpretationForTwoRunes.text(description)
        case .norns:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            descriptionLabelString = L10n.InterpretationForNorns.text(firstRune.value, secondRune.value, thirdRune.value)
        case .shortPrediction:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            descriptionLabelString = L10n.InterpretationForShortPrediction.text(firstRune.value, secondRune.value, thirdRune.value, fourthRune.value)
        case .thorsHummer:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let fourthRune = runesViewContainer.runesSet[3]
            descriptionLabelString = L10n.InterpretationForThorsHummer.text(firstRune.value, secondRune.value, fourthRune.value)
        case .cross:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            let fifthRune = runesViewContainer.runesSet[4]
            descriptionLabelString = L10n.InterpretationForСross.text(firstRune.value, secondRune.value, thirdRune.value, fifthRune.value, fourthRune.value)
        case .elementsCross:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            let fifthRune = runesViewContainer.runesSet[4]
            let sixthRune = runesViewContainer.runesSet[5]
            descriptionLabelString = L10n.InterpretationElementsCross.text(secondRune.value, firstRune.value, fourthRune.value, thirdRune.value, fifthRune.value, sixthRune.value)
        case .keltsCross:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            let fifthRune = runesViewContainer.runesSet[4]
            let sixthRune = runesViewContainer.runesSet[5]
            let seventhRune = runesViewContainer.runesSet[6]
            descriptionLabelString = L10n.InterpretationKeltsCross.text(firstRune.value, secondRune.value, thirdRune.value, fourthRune.value, fifthRune.value, sixthRune.value, seventhRune.value)
        }
        let font: CGFloat = DeviceType.iPhoneSE ? 16 : 19
        descriptionLabel.font = FontFamily.SFProDisplay.light.font(size: font)
        descriptionLabel.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        descriptionLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.22
        descriptionLabel.attributedText = NSAttributedString(string: descriptionLabelString, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dividingLine.bottomAnchor, constant: 32.heightDependent()),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24.heightDependent()),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor, constant: -24.heightDependent()),
        ])
    }
    
    // MARK: - AffirmationLabel
    
    func setUpAffirmationLabel() {
        var affirmationText = String()
        if totalLuck>39 && totalLuck<=50 {
            affirmationText = affirmation.fourtyPercent.randomElement() ?? ""
        } else if totalLuck>29 && totalLuck<=39 {
            affirmationText = affirmation.thirtyPercent.randomElement() ?? ""
        } else if totalLuck>19 && totalLuck<=29 {
            affirmationText = affirmation.twentyPercent.randomElement() ?? ""
        } else if totalLuck>=10 && totalLuck<=19 {
            affirmationText = affirmation.tenPercent.randomElement() ?? ""
        } else {
            affirmationLabel.isHidden = true
        }
        let font: CGFloat = DeviceType.iPhoneSE ? 16 : 19
        affirmationLabel.font = FontFamily.SFProDisplay.light.font(size: font)
        affirmationLabel.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        affirmationLabel.numberOfLines = 0
        affirmationLabel.sizeToFit()
        affirmationLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.22
        affirmationLabel.attributedText = NSAttributedString(string: affirmationText, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
        affirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(affirmationLabel)
        NSLayoutConstraint.activate([
            affirmationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            affirmationLabel.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24.heightDependent()),
            affirmationLabel.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor, constant: -24.heightDependent()),
        ])
    }
    
    
    //-------------------------------------------------
    // MARK: - CheckBox
    //-------------------------------------------------
    
    func setUpCheckBox(){
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.setImage(UIImage(named: "unselected"), for: .normal)
        checkButton.addTarget(self, action: #selector(select), for: .touchUpInside)
        
        let widthContant: CGFloat = DeviceType.iPhoneSE ? 16.44 : 20
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 16.44 : 20
        
        NSLayoutConstraint.activate([
            
            checkButton.widthAnchor.constraint(equalToConstant: widthContant),
            checkButton.heightAnchor.constraint(equalToConstant: heightConstant),
        ])
        
    }
    
    func setUpCheckLabel() {
        checkLabel.text = String.saveResult
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 14 : 16
        checkLabel.font = FontFamily.Roboto.light.font(size: fontConstant)
        checkLabel.textColor = UIColor(red: 0.659, green: 0.651, blue: 0.639, alpha: 1)
        checkLabel.textAlignment = .left
        let heightAnchor: CGFloat = DeviceType.iPhoneSE ? 23.02 : 28
        NSLayoutConstraint.activate([
            
            checkLabel.heightAnchor.constraint(equalToConstant: heightAnchor)
            
        ])
    }
    
    func setUpCheckStack() {
        checkStack.translatesAutoresizingMaskIntoConstraints = false
        checkStack.axis = .horizontal
        checkStack.distribution = .equalSpacing
        let spacing: CGFloat = DeviceType.iPhoneSE ? 9.86 : 12
        checkStack.spacing = spacing
        
        contentInterpretationView.addSubview(checkStack)
        checkStack.addArrangedSubview(checkButton)
        checkStack.addArrangedSubview(checkLabel)
        
        let bottomAnchor: CGFloat = DeviceType.iPhoneSE ? -13.15 : -27
        
        NSLayoutConstraint.activate([
            checkStack.centerXAnchor.constraint(equalTo: contentInterpretationView.centerXAnchor),
            checkStack.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: bottomAnchor)
            
        ])
    }
    
    @objc func select(sender: UIButton!) {
        if let button = sender {
            if button.isSelected {
                checkButton.setImage(UIImage(named: "unselected"), for: .normal)
                button.isSelected = false
            } else {
                checkButton.setImage(UIImage(named: "selected"), for: .selected)
                button.isSelected = true
            }
        }
    }
    
    // MARK: - CompleteButton
    
    func setUpCancel() {
        cancelButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        cancelButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 6.58 : 8
        cancelButton.layer.cornerRadius = radiusConstant
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        cancelButton.layer.borderWidth = borderConstant
        cancelButton.setTitle(String.complete, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        cancelButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        cancelButton.addTarget(self, action: #selector(self.exitTapped), for: .touchUpInside)
        cancelButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        cancelButton.setTitleColor(UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1), for: .highlighted)
        contentInterpretationView.addSubview(cancelButton)
        
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        let widthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        
        if affirmationLabel.isHidden {
            cancelButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 57.5.heightDependent()).isActive = true
        } else {
            cancelButton.topAnchor.constraint(equalTo: affirmationLabel.bottomAnchor, constant: 57.5.heightDependent()).isActive = true
        }
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: heightConstant),
            cancelButton.widthAnchor.constraint(equalToConstant: widthConsatnt),
            cancelButton.centerXAnchor.constraint(equalTo: contentInterpretationView.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: contentInterpretationView.bottomAnchor, constant: -50.heightDependent())
        ])
    }
    @objc func exitTapped(sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
