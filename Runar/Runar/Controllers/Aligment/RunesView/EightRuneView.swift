//
//  EightRuneView.swift
//  Runar
//
//  Created by Oleg Kanatov on 24.01.21.
//

import UIKit
import Combine

class EightRuneView: UIView, RuneViewProtocol {
    
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
        
        configureIndexesAndButtons(count: 7, availableRunes: RuneType.allCases(subtype: .random))
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
            let buttonSix = getButton(index: 5),
            let buttonSeven = getButton(index: 6)
        else {
            assertionFailure("Unexpected number of buttons. Expected number: 7. ExistingNumber: \(indexesAndButtons.count)")
            return
        }
        
        NSLayoutConstraint.activate([

            buttonThree.trailingAnchor.constraint(equalTo: buttonOne.leadingAnchor, constant: -24.heightDependent()),
            buttonThree.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonThree.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonThree.heightAnchor.constraint(equalToConstant: 90.heightDependent()),

            buttonOne.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonOne.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonOne.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 90.heightDependent()),

            buttonTwo.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: 24.heightDependent()),
            buttonTwo.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonTwo.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonTwo.heightAnchor.constraint(equalToConstant: 90.heightDependent()),

            buttonFour.topAnchor.constraint(equalTo: buttonFive.bottomAnchor, constant: 24.heightDependent()),
            buttonFour.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonFour.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonFour.heightAnchor.constraint(equalToConstant: 90.heightDependent()),

            buttonFive.topAnchor.constraint(equalTo: buttonOne.bottomAnchor, constant: 24.heightDependent()),
            buttonFive.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonFive.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonFive.heightAnchor.constraint(equalToConstant: 90.heightDependent()),

            buttonSix.bottomAnchor.constraint(equalTo: buttonOne.topAnchor, constant: -24.heightDependent()),
            buttonSix.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonSix.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonSix.heightAnchor.constraint(equalToConstant: 90.heightDependent()),

            buttonSeven.bottomAnchor.constraint(equalTo: buttonSix.topAnchor, constant: -24.heightDependent()),
            buttonSeven.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonSeven.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonSeven.heightAnchor.constraint(equalToConstant: 90.heightDependent()),
            
            
            buttonSeven.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            buttonFour.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            buttonThree.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            buttonTwo.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])
    }
}
