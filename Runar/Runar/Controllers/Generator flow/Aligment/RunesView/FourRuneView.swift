//
//  FourRuneView.swift
//  Runar
//
//  Created by Oleg Kanatov on 24.01.21.
//

import UIKit
import Combine

class FourRuneView: UIView, RuneViewProtocol {
    
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
        
        configureIndexesAndButtons(count: 4, availableRunes: RuneType.allCases(subtype: .original))
        addButtons()
        setupViewConstraints()
        highlightFirstButton()
    }
    
    private func setupViewConstraints() {
        guard
            let buttonOne = getButton(index: 0),
            let buttonTwo = getButton(index: 1),
            let buttonThree = getButton(index: 2),
            let buttonFour = getButton(index: 3)
        else {
            assertionFailure("Unexpected number of buttons. Expected number: 4. ExistingNumber: \(indexesAndButtons.count)")
            return
        }
        
        NSLayoutConstraint.activate([

            buttonOne.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonOne.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: -76.heightDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 100.heightDependent()),
            
            buttonTwo.trailingAnchor.constraint(equalTo: buttonOne.leadingAnchor, constant: -28.heightDependent()),
            buttonTwo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonTwo.widthAnchor.constraint(equalToConstant: 76.heightDependent()),
            buttonTwo.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: -100.heightDependent()),
            
            buttonThree.widthAnchor.constraint(equalToConstant: 76.heightDependent()),
            buttonThree.heightAnchor.constraint(equalToConstant: 100.heightDependent()),
            buttonThree.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: 25.heightDependent()),
            buttonThree.trailingAnchor.constraint(equalTo: buttonOne.leadingAnchor, constant: -28.heightDependent()),
            
            buttonFour.widthAnchor.constraint(equalToConstant: 76.heightDependent()),
            buttonFour.heightAnchor.constraint(equalToConstant: 100.heightDependent()),
            buttonFour.bottomAnchor.constraint(equalTo: buttonTwo.topAnchor, constant: -25.heightDependent()),
            buttonFour.trailingAnchor.constraint(equalTo: buttonOne.leadingAnchor, constant: -28.heightDependent()),
            
            buttonFour.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            buttonThree.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            buttonTwo.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            buttonOne.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])
    }
}
