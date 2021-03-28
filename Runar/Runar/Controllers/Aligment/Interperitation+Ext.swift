//
//  Interperitation+Ext.swift
//  Runar
//
//  Created by Юлия Лопатина on 5.03.21.
//

import UIKit

extension AlignmentViewController {
    
    //-------------------------------------------------
    // MARK: - After advertising
    //-------------------------------------------------
//    var containerTopAnchor : NSLayoutConstraint
    
    func setUpContentAfterAdvertising() {
        scrollViewAlignment.isScrollEnabled = true
        
        stack.removeFromSuperview()
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
    }
    
    
    func removeConstant() {
        runesViewContainer.removeFromSuperview()
        runesViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(runesViewContainer)
        containerTopAnchor = runesViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 162.heightDependent())
        containerTopAnchor!.isActive = true
        NSLayoutConstraint.activate([
            runesViewContainer.centerXAnchor.constraint(equalTo: scrollViewAlignment.centerXAnchor),
            runesViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            runesViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
    
    func setUpContentInterpretationView() {
        let backgroundImage: UIImage = {
            let image = Assets.interpretationBackground.image
            return image
        }()
        
        contentInterpretationView.backgroundColor = UIColor(patternImage: backgroundImage)
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
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .twoRunes:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[0].luck
            let luck2 = runesViewContainer.runesSet[1].luck
            totalLuck = (luck1 + luck2)/2
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .norns:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            totalLuck = runesViewContainer.runesSet[2].luck
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .shortPrediction:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[3].luck
            totalLuck = (luck1 + luck2)/2
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .thorsHummer:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[1].luck
            let luck2 = runesViewContainer.runesSet[2].luck
            let luck3 = runesViewContainer.runesSet[3].luck
            totalLuck = (luck1 + luck2 + luck3)/3
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .cross:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[3].luck
            let luck3 = runesViewContainer.runesSet[4].luck
            totalLuck = (luck1 + luck2 + luck3)/3
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .elementsCross:
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[4].luck
            let luck3 = runesViewContainer.runesSet[5].luck
            totalLuck = (luck1 + luck2 + luck3)/3
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        case .keltsCross:
            guard !runesViewContainer.runesSet.isEmpty else {return}
            let luck1 = runesViewContainer.runesSet[2].luck
            let luck2 = runesViewContainer.runesSet[4].luck
            let luck3 = runesViewContainer.runesSet[5].luck
            let luck4 = runesViewContainer.runesSet[5].luck
            totalLuck = (luck1 + luck2 + luck3 + luck4)/4
            luckLevelLabel.text = "Уровень удачи - \(String(totalLuck)) %"
        }
        
        luckLevelLabel.font = FontFamily.SFProDisplay.light.font(size: 20.heightDependent())
        luckLevelLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        luckLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(luckLevelLabel)
        NSLayoutConstraint.activate([
            luckLevelLabel.topAnchor.constraint(equalTo: contentInterpretationView.topAnchor, constant: 76.heightDependent()),
            luckLevelLabel.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24.heightDependent()),
            luckLevelLabel.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor,constant: -24.heightDependent()),
        ])
    }
    
    func setUpDividingLine() {
        dividingLine.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.3)
        dividingLine.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(dividingLine)
        
        NSLayoutConstraint.activate([
            dividingLine.topAnchor.constraint(equalTo: luckLevelLabel.bottomAnchor, constant: 27.heightDependent()),
            dividingLine.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24.heightDependent()),
            dividingLine.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor, constant: -24.heightDependent()),
            dividingLine.heightAnchor.constraint(equalToConstant: 1.heightDependent())
        ])
        
    }
    
    // MARK: - DescriptionLabel
    
    func setUpDescriptionLabel() {
        
        descriptionLabel.font = FontFamily.Roboto.thin.font(size: 19.heightDependent())
        descriptionLabel.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        descriptionLabel.numberOfLines = 0
        
        switch runesViewContainer.runeLayout {
        case .dayRune:
            descriptionLabel.text = runesViewContainer.runesSet[0].description
            descriptionLabel.font = FontFamily.Roboto.light.font(size: 19.heightDependent())
        case .twoRunes:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let description = firstRune.cross(runeType: secondRune)
            descriptionLabel.text = L10n.InterpretationForTwoRunes.text(description)
            
            guard let textDescription = descriptionLabel.text else { return }
            let changeColor = NSString(string: textDescription)
            let text = NSMutableAttributedString(string: changeColor as String)
        
            text.addAttributes(
                [.font: FontFamily.Roboto.light.font(size: 19)],
                               range: changeColor.range(of: description))
            descriptionLabel.attributedText = text
        case .norns:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            descriptionLabel.text = L10n.InterpretationForNorns.text(firstRune.value, secondRune.value, thirdRune.value)
            
            guard let textDescription = descriptionLabel.text else { return }
            let changeColor = NSString(string: textDescription)
            let text = NSMutableAttributedString(string: changeColor as String)
            
            [firstRune.value, secondRune.value, thirdRune.value].forEach {
            text.addAttributes(
                [.font: FontFamily.Roboto.light.font(size: 19)],
                               range: changeColor.range(of: $0))
            }
            descriptionLabel.attributedText = text
        case .shortPrediction:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            descriptionLabel.text = L10n.InterpretationForShortPrediction.text(firstRune.value, secondRune, thirdRune.value, fourthRune.value)
            
            guard let textDescription = descriptionLabel.text else { return }
            let changeColor = NSString(string: textDescription)
            let text = NSMutableAttributedString(string: changeColor as String)
            
            [firstRune.value, secondRune.value, thirdRune.value, fourthRune.value].forEach {
            text.addAttributes(
                [.font: FontFamily.Roboto.light.font(size: 19)],
                               range: changeColor.range(of: $0))
            }
            descriptionLabel.attributedText = text
        case .thorsHummer:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let fourthRune = runesViewContainer.runesSet[3]
            descriptionLabel.text = L10n.InterpretationForThorsHummer.text(firstRune.value, secondRune.value, fourthRune.value)
            
            guard let textDescription = descriptionLabel.text else { return }
            let changeColor = NSString(string: textDescription)
            let text = NSMutableAttributedString(string: changeColor as String)
            
            [firstRune.value, secondRune.value, fourthRune.value].forEach {
            text.addAttributes(
                [.font: FontFamily.Roboto.light.font(size: 19)],
                               range: changeColor.range(of: $0))
            }
            descriptionLabel.attributedText = text
        case .cross:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            let fifthRune = runesViewContainer.runesSet[4]
            descriptionLabel.text = L10n.InterpretationForСross.text(firstRune.value, secondRune.value, thirdRune.value, fifthRune.value, fourthRune.value)
            
            guard let textDescription = descriptionLabel.text else { return }
            let changeColor = NSString(string: textDescription)
            let text = NSMutableAttributedString(string: changeColor as String)
            
            [firstRune.value, secondRune.value, thirdRune.value, fourthRune.value, fifthRune.value].forEach {
            text.addAttributes(
                [.font: FontFamily.Roboto.light.font(size: 19)],
                               range: changeColor.range(of: $0))
            }
            descriptionLabel.attributedText = text
        case .elementsCross:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            let fifthRune = runesViewContainer.runesSet[4]
            let sixthRune = runesViewContainer.runesSet[5]
            descriptionLabel.text = L10n.InterpretationElementsCross.text(secondRune.value, firstRune.value, fourthRune.value, thirdRune.value, fifthRune.value, sixthRune.value)
            
            guard let textDescription = descriptionLabel.text else { return }
            let changeColor = NSString(string: textDescription)
            let text = NSMutableAttributedString(string: changeColor as String)
            
            [firstRune.value, secondRune.value, thirdRune.value, fourthRune.value, fifthRune.value, sixthRune.value].forEach {
            text.addAttributes(
                [.font: FontFamily.Roboto.light.font(size: 19)],
                               range: changeColor.range(of: $0))
            }
            descriptionLabel.attributedText = text
        case .keltsCross:
            let firstRune = runesViewContainer.runesSet[0]
            let secondRune = runesViewContainer.runesSet[1]
            let thirdRune = runesViewContainer.runesSet[2]
            let fourthRune = runesViewContainer.runesSet[3]
            let fifthRune = runesViewContainer.runesSet[4]
            let sixthRune = runesViewContainer.runesSet[5]
            let seventhRune = runesViewContainer.runesSet[6]
            descriptionLabel.text = L10n.InterpretationKeltsCross.text(firstRune.value, secondRune.value, thirdRune.value, fourthRune.value, fifthRune.value, sixthRune.value, seventhRune.value)
            
            guard let textDescription = descriptionLabel.text else { return }
            let changeColor = NSString(string: textDescription)
            let text = NSMutableAttributedString(string: changeColor as String)
            
            [firstRune.value, secondRune.value, thirdRune.value, fourthRune.value, fifthRune.value, sixthRune.value, seventhRune.value].forEach {
            text.addAttributes(
                [.font: FontFamily.Roboto.light.font(size: 19)],
                               range: changeColor.range(of: $0))
            }
            descriptionLabel.attributedText = text
        }
        
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
        
        affirmationLabel.font = FontFamily.SFProDisplay.light.font(size: 20.heightDependent())
        affirmationLabel.textColor = Assets.Colors.Touch.text.color
        affirmationLabel.numberOfLines = 0
        affirmationLabel.sizeToFit()
        affirmationLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.22
        affirmationLabel.attributedText = NSAttributedString(string: affirmationText, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
        affirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentInterpretationView.addSubview(affirmationLabel)
        NSLayoutConstraint.activate([
            affirmationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30.heightDependent()),
            affirmationLabel.leadingAnchor.constraint(equalTo: contentInterpretationView.leadingAnchor, constant: 24.heightDependent()),
            affirmationLabel.trailingAnchor.constraint(equalTo: contentInterpretationView.trailingAnchor, constant: -24.heightDependent()),
        ])
    }
    
    // MARK: - CompleteButton
    
    func setUpCancel() {
        cancelButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        cancelButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 6.58 : 8
        cancelButton.layer.cornerRadius = radiusConstant
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        cancelButton.layer.borderWidth = borderConstant
        cancelButton.setTitle("Завершить", for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        cancelButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        cancelButton.addTarget(self, action: #selector(self.escapeOnTap), for: .touchUpInside)
        cancelButton.setTitleColor(Assets.Colors.textColor.color, for: .normal)
        cancelButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        contentInterpretationView.addSubview(cancelButton)
        
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        let widthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        
        if affirmationLabel.isHidden {
            cancelButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 60.heightDependent()).isActive = true
        } else {
            cancelButton.topAnchor.constraint(equalTo: affirmationLabel.bottomAnchor, constant: 60.heightDependent()).isActive = true
        }
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: heightConstant),
            cancelButton.widthAnchor.constraint(equalToConstant: widthConsatnt),
            cancelButton.centerXAnchor.constraint(equalTo: contentInterpretationView.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: contentInterpretationView.bottomAnchor, constant: -75)
        ])
    }
}
