//
//  FiveRuneView.swift
//  Runar
//
//  Created by Oleg Kanatov on 24.01.21.
//

import UIKit
import Combine

class FiveRuneView: UIView, RuneViewProtocol {
    
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
        
        configureIndexesAndButtons(count: 4, availableRunes: RuneType.allCases(subtype: .random))
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

            buttonOne.leadingAnchor.constraint(equalTo: buttonFour.trailingAnchor, constant: -76.heightDependent()),
            buttonOne.topAnchor.constraint(equalTo: buttonFour.bottomAnchor, constant: 25.heightDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 100.heightDependent()),
            buttonOne.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonTwo.trailingAnchor.constraint(equalTo: buttonFour.leadingAnchor, constant: -28.heightDependent()),
            buttonTwo.topAnchor.constraint(equalTo: buttonFour.bottomAnchor, constant: -32.heightDependent()),
            buttonTwo.widthAnchor.constraint(equalToConstant: 76.heightDependent()),
            buttonTwo.heightAnchor.constraint(equalToConstant: 100.heightDependent()),
            
            buttonThree.leadingAnchor.constraint(equalTo: buttonFour.trailingAnchor, constant: 28.heightDependent()),
            buttonThree.topAnchor.constraint(equalTo: buttonFour.bottomAnchor, constant: -32.heightDependent()),
            buttonThree.widthAnchor.constraint(equalToConstant: 76.heightDependent()),
            buttonThree.heightAnchor.constraint(equalToConstant: 100.heightDependent()),
            
            buttonFour.leadingAnchor.constraint(equalTo: buttonFour.trailingAnchor, constant: -76.heightDependent()),
            buttonFour.bottomAnchor.constraint(equalTo: buttonFour.topAnchor, constant: 100.heightDependent()),
            buttonFour.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonFour.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            buttonOne.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            buttonTwo.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            buttonThree.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])
    }
}
