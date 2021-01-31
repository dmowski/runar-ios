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
        
        configureIndexesAndButtons(count: 7)
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
            buttonThree.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 81.widthDependent()),
            buttonThree.trailingAnchor.constraint(equalTo: buttonThree.leadingAnchor, constant: 68.widthDependent()),
            buttonThree.topAnchor.constraint(equalTo: self.topAnchor, constant: 251.widthDependent()),
            buttonThree.bottomAnchor.constraint(equalTo: buttonThree.topAnchor, constant: 90.widthDependent()),

            buttonOne.leadingAnchor.constraint(equalTo: buttonThree.trailingAnchor, constant: 24.widthDependent()),
            buttonOne.topAnchor.constraint(equalTo: self.topAnchor, constant: 251.widthDependent()),
            buttonOne.bottomAnchor.constraint(equalTo: buttonThree.topAnchor, constant: 90.widthDependent()),
            buttonOne.trailingAnchor.constraint(equalTo: buttonOne.leadingAnchor, constant: 68.widthDependent()),

            buttonTwo.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: 24.widthDependent()),
            buttonTwo.topAnchor.constraint(equalTo: self.topAnchor, constant: 251.widthDependent()),
            buttonTwo.bottomAnchor.constraint(equalTo: buttonTwo.topAnchor, constant: 90.widthDependent()),
            buttonTwo.trailingAnchor.constraint(equalTo: buttonTwo.leadingAnchor, constant: 68.widthDependent()),

            buttonFour.topAnchor.constraint(equalTo: buttonFive.bottomAnchor, constant: 24.widthDependent()),
            buttonFour.leadingAnchor.constraint(equalTo: buttonThree.trailingAnchor, constant: 24.widthDependent()),
            buttonFour.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonFour.heightAnchor.constraint(equalToConstant: 90.widthDependent()),

            buttonFive.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: 24.widthDependent()),
            buttonFive.leadingAnchor.constraint(equalTo: buttonThree.trailingAnchor, constant: 24.widthDependent()),
            buttonFive.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonFive.heightAnchor.constraint(equalToConstant: 90.widthDependent()),

            buttonSix.bottomAnchor.constraint(equalTo: buttonOne.topAnchor, constant: -24.widthDependent()),
            buttonSix.leadingAnchor.constraint(equalTo: buttonThree.trailingAnchor, constant: 24.widthDependent()),
            buttonSix.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonSix.heightAnchor.constraint(equalToConstant: 90.widthDependent()),

            buttonSeven.bottomAnchor.constraint(equalTo: buttonSix.topAnchor, constant: -24.widthDependent()),
            buttonSeven.leadingAnchor.constraint(equalTo: buttonThree.trailingAnchor, constant: 24.widthDependent()),
            buttonSeven.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonSeven.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
        ])
    }
}
