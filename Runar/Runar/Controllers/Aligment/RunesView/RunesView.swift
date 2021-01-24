//
//  RunesView.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import UIKit

class RunesView: UIView {
    
    private let firstRuneView = FirstRuneView()
    private let twoRuneView = TwoRuneView()
    private let threeRuneView = ThreeRuneView()
    private let fourRuneView = FourRuneView()
    private let fiveRuneView = FiveRuneView()
    private let sixRuneView = SixRuneView()
    private let sevenRuneView = SevenRuneView()
    private let eightRuneView = EightRuneView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpContent()
    }
    
    private func setUpContent() {
        firstRuneView.translatesAutoresizingMaskIntoConstraints = false
        twoRuneView.translatesAutoresizingMaskIntoConstraints = false
        threeRuneView.translatesAutoresizingMaskIntoConstraints = false
        fourRuneView.translatesAutoresizingMaskIntoConstraints = false
        fiveRuneView.translatesAutoresizingMaskIntoConstraints = false
        sixRuneView.translatesAutoresizingMaskIntoConstraints = false
        sevenRuneView.translatesAutoresizingMaskIntoConstraints = false
        eightRuneView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(firstRuneView)
        addSubview(twoRuneView)
        addSubview(threeRuneView)
        addSubview(fourRuneView)
        addSubview(fiveRuneView)
        addSubview(sixRuneView)
        addSubview(sevenRuneView)
        addSubview(eightRuneView)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: firstRuneView.topAnchor),
            self.bottomAnchor.constraint(equalTo: firstRuneView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: firstRuneView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: firstRuneView.trailingAnchor),
            
            self.topAnchor.constraint(equalTo: twoRuneView.topAnchor),
            self.bottomAnchor.constraint(equalTo: twoRuneView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: twoRuneView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: twoRuneView.trailingAnchor),
            
            self.topAnchor.constraint(equalTo: threeRuneView.topAnchor),
            self.bottomAnchor.constraint(equalTo: threeRuneView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: threeRuneView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: threeRuneView.trailingAnchor),
            
            self.topAnchor.constraint(equalTo: fourRuneView.topAnchor),
            self.bottomAnchor.constraint(equalTo: fourRuneView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: fourRuneView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: fourRuneView.trailingAnchor),
            
            self.topAnchor.constraint(equalTo: fiveRuneView.topAnchor),
            self.bottomAnchor.constraint(equalTo: fiveRuneView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: fiveRuneView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: fiveRuneView.trailingAnchor),
            
            self.topAnchor.constraint(equalTo: sixRuneView.topAnchor),
            self.bottomAnchor.constraint(equalTo: sixRuneView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: sixRuneView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: sixRuneView.trailingAnchor),
            
            self.topAnchor.constraint(equalTo: sevenRuneView.topAnchor),
            self.bottomAnchor.constraint(equalTo: sevenRuneView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: sevenRuneView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: sevenRuneView.trailingAnchor),
            
            self.topAnchor.constraint(equalTo: eightRuneView.topAnchor),
            self.bottomAnchor.constraint(equalTo: eightRuneView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: eightRuneView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: eightRuneView.trailingAnchor),
        ])
        
        setRuneLayout(.dayRune)
    }
    
    func setRuneLayout(_ runeLayout: RuneLayout) {
        switch runeLayout {
        case .dayRune:
            firstRuneView.isHidden = false
            twoRuneView.isHidden = true
            threeRuneView.isHidden = true
            fourRuneView.isHidden = true
            fiveRuneView.isHidden = true
            sixRuneView.isHidden = true
            sevenRuneView.isHidden = true
            eightRuneView.isHidden = true
        case .twoRunes:
            firstRuneView.isHidden = true
            twoRuneView.isHidden = false
            threeRuneView.isHidden = true
            fourRuneView.isHidden = true
            fiveRuneView.isHidden = true
            sixRuneView.isHidden = true
            sevenRuneView.isHidden = true
            eightRuneView.isHidden = true
        case .norns:
            firstRuneView.isHidden = true
            twoRuneView.isHidden = true
            threeRuneView.isHidden = false
            fourRuneView.isHidden = true
            fiveRuneView.isHidden = true
            sixRuneView.isHidden = true
            sevenRuneView.isHidden = true
            eightRuneView.isHidden = true
        case .shortPrediction:
            firstRuneView.isHidden = true
            twoRuneView.isHidden = true
            threeRuneView.isHidden = true
            fourRuneView.isHidden = false
            fiveRuneView.isHidden = true
            sixRuneView.isHidden = true
            sevenRuneView.isHidden = true
            eightRuneView.isHidden = true
        case .thorsHummer:
            firstRuneView.isHidden = true
            twoRuneView.isHidden = true
            threeRuneView.isHidden = true
            fourRuneView.isHidden = true
            fiveRuneView.isHidden = false
            sixRuneView.isHidden = true
            sevenRuneView.isHidden = true
            eightRuneView.isHidden = true
        case .cross:
            firstRuneView.isHidden = true
            twoRuneView.isHidden = true
            threeRuneView.isHidden = true
            fourRuneView.isHidden = true
            fiveRuneView.isHidden = true
            sixRuneView.isHidden = false
            sevenRuneView.isHidden = true
            eightRuneView.isHidden = true
        case .elementsCross:
            firstRuneView.isHidden = true
            twoRuneView.isHidden = true
            threeRuneView.isHidden = true
            fourRuneView.isHidden = true
            fiveRuneView.isHidden = true
            sixRuneView.isHidden = true
            sevenRuneView.isHidden = false
            eightRuneView.isHidden = true
        case .keltsCross:
            firstRuneView.isHidden = true
            twoRuneView.isHidden = true
            threeRuneView.isHidden = true
            fourRuneView.isHidden = true
            fiveRuneView.isHidden = true
            sixRuneView.isHidden = true
            sevenRuneView.isHidden = true
            eightRuneView.isHidden = false
        }
    }
}

