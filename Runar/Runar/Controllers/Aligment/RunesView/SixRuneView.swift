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
        
        configureIndexesAndButtons(count: 5)
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
            buttonOne.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 81.widthDependent()),
            buttonOne.trailingAnchor.constraint(equalTo: buttonOne.leadingAnchor, constant: 68.widthDependent()),
            buttonOne.topAnchor.constraint(equalTo: self.topAnchor, constant: 251.widthDependent()),
            buttonOne.bottomAnchor.constraint(equalTo: buttonOne.topAnchor, constant: 90.widthDependent()),
            
            buttonTwo.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: 24.widthDependent()),
            buttonTwo.topAnchor.constraint(equalTo: self.topAnchor, constant: 251.widthDependent()),
            buttonTwo.bottomAnchor.constraint(equalTo: buttonOne.topAnchor, constant: 90.widthDependent()),
            buttonTwo.trailingAnchor.constraint(equalTo: buttonTwo.leadingAnchor, constant: 68.widthDependent()),
            
            buttonThree.leadingAnchor.constraint(equalTo: buttonTwo.trailingAnchor, constant: 24.widthDependent()),
            buttonThree.topAnchor.constraint(equalTo: self.topAnchor, constant: 251.widthDependent()),
            buttonThree.bottomAnchor.constraint(equalTo: buttonThree.topAnchor, constant: 90.widthDependent()),
            buttonThree.trailingAnchor.constraint(equalTo: buttonThree.leadingAnchor, constant: 68.widthDependent()),
            
            buttonFour.bottomAnchor.constraint(equalTo: buttonTwo.topAnchor, constant: -24.widthDependent()),
            buttonFour.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: 24.widthDependent()),
            buttonFour.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonFour.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
            
            buttonFive.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: 24.widthDependent()),
            buttonFive.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: 24.widthDependent()),
            buttonFive.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonFive.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
        ])
    }
}
