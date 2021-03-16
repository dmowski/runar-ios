//
//  SevenRuneView.swift
//  Runar
//
//  Created by Oleg Kanatov on 24.01.21.
//

import UIKit
import Combine

class SevenRuneView: UIView, RuneViewProtocol {
    
    //-------------------------------------------------
    // MARK: - Variables
    //-------------------------------------------------
    
    public var highlightedButton: RuneButton?
    public var viewModel: RunesView.ViewModel?
    public var runesSet: [RuneType] = []
    public var cancellables: [AnyCancellable] = []
    public var indexesAndButtons: [Int : RuneButton] = [:]
    
    //-------------------------------------------------
    // MARK: - Methods
    //-------------------------------------------------
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpContent()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpContent()
    }
    
    private func setUpContent() {
        
        configureIndexesAndButtons(count: 6, availableRunes: RuneType.allCases(subtype: .random))
        addButtons()
        setupViewConstraints()
        highlightFirstButton()
    }
    
    private func setupViewConstraints() {
        guard
            let buttonOne = getButton(index: 0),
            let buttonTwo = getButton(index: 1),
            let buttonThree = getButton(index: 2),
            let buttonFour = getButton(index: 3),
            let buttonFive = getButton(index: 4),
            let buttonSix = getButton(index: 5)
        else {
            assertionFailure("Unexpected number of buttons. Expected number: 6. ExistingNumber: \(indexesAndButtons.count)")
            return
        }
        
        NSLayoutConstraint.activate([
            buttonThree.trailingAnchor.constraint(equalTo: buttonTwo.leadingAnchor, constant: -24.heightDependent()),
            buttonThree.bottomAnchor.constraint(equalTo: buttonTwo.bottomAnchor),
            buttonThree.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonThree.heightAnchor.constraint(equalToConstant: 90.heightDependent()),
            
            buttonTwo.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonTwo.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonTwo.heightAnchor.constraint(equalToConstant: 90.heightDependent()),

            buttonOne.leadingAnchor.constraint(equalTo: buttonTwo.trailingAnchor, constant: 24.heightDependent()),
            buttonOne.bottomAnchor.constraint(equalTo: buttonTwo.bottomAnchor),
            buttonOne.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 90.heightDependent()),
            
            buttonFive.bottomAnchor.constraint(equalTo: buttonTwo.topAnchor, constant: -24.heightDependent()),
            buttonFive.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonFive.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonFive.heightAnchor.constraint(equalToConstant: 90.heightDependent()),

            buttonFour.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: 24.heightDependent()),
            buttonFour.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonFour.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonFour.heightAnchor.constraint(equalToConstant: 90.heightDependent()),

            buttonSix.bottomAnchor.constraint(equalTo: buttonFive.topAnchor, constant: -24.heightDependent()),
            buttonSix.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonSix.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonSix.heightAnchor.constraint(equalToConstant: 90.heightDependent()),
            
            buttonSix.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            buttonFour.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            buttonThree.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            buttonOne.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])
    }
}

