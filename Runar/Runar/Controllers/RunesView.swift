//
//  RunesView.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import UIKit

class RunesView: UIView {
    
    private let firstRunView = FirstRunView()
    private let twoRunView = TwoRunView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpContent()
    }
    
    private func setUpContent() {
        firstRunView.translatesAutoresizingMaskIntoConstraints = false
        twoRunView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(firstRunView)
        addSubview(twoRunView)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: firstRunView.topAnchor),
            self.bottomAnchor.constraint(equalTo: firstRunView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: firstRunView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: firstRunView.trailingAnchor),
            
            self.topAnchor.constraint(equalTo: twoRunView.topAnchor),
            self.bottomAnchor.constraint(equalTo: twoRunView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: twoRunView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: twoRunView.trailingAnchor),
        ])
        
        setRuneLayout(.dayRune)
    }
    
    func setRuneLayout(_ runeLayout: RuneLayout) {
        switch runeLayout {
        case .dayRune:
            firstRunView.isHidden = false
            twoRunView.isHidden = true
        case .twoRunes:
            firstRunView.isHidden = true
            twoRunView.isHidden = false
        default: break
        }
    }
}

