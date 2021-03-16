//
//  SixRuneView.swift
//  Runar
//
//  Created by Oleg Kanatov on 24.01.21.
//

import UIKit
import Combine

class SixRuneView: UIView, RuneViewProtocol {
    
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
        
        configureIndexesAndButtons(count: 5, availableRunes: RuneType.allCases(subtype: .random))
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
            let buttonFive = getButton(index: 4)
        else {
            assertionFailure("Unexpected number of buttons. Expected number: 5. ExistingNumber: \(indexesAndButtons.count)")
            return
        }
        
        NSLayoutConstraint.activate([

            buttonOne.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonOne.trailingAnchor.constraint(equalTo: buttonTwo.leadingAnchor, constant: -24.heightDependent()),
            buttonOne.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 90.heightDependent()),
            
            buttonTwo.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonTwo.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonTwo.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonTwo.heightAnchor.constraint(equalToConstant: 90.heightDependent()),
            
            buttonThree.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonThree.leadingAnchor.constraint(equalTo: buttonTwo.trailingAnchor, constant: 24.heightDependent()),
            buttonThree.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonThree.heightAnchor.constraint(equalToConstant: 90.heightDependent()),
            
            buttonFour.bottomAnchor.constraint(equalTo: buttonTwo.topAnchor, constant: -24.heightDependent()),
            buttonFour.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonFour.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonFour.heightAnchor.constraint(equalToConstant: 90.heightDependent()),
            
            buttonFive.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: 24.heightDependent()),
            buttonFive.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonFive.widthAnchor.constraint(equalToConstant: 68.heightDependent()),
            buttonFive.heightAnchor.constraint(equalToConstant: 90.heightDependent()),
            
            buttonFour.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            buttonFive.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            buttonOne.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            buttonThree.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])
    }
}
