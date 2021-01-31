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
        
        configureIndexesAndButtons(count: 4)
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
            buttonOne.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -127.widthDependent()),
            buttonOne.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonOne.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: -68.widthDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
            
            buttonTwo.trailingAnchor.constraint(equalTo: buttonOne.leadingAnchor, constant: -24.widthDependent()),
            buttonTwo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonTwo.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonTwo.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: -90.widthDependent()),
            
            buttonThree.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonThree.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
            buttonThree.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: 24.widthDependent()),
            buttonThree.trailingAnchor.constraint(equalTo: buttonOne.leadingAnchor, constant: -24.widthDependent()),
            
            buttonFour.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonFour.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
            buttonFour.bottomAnchor.constraint(equalTo: buttonTwo.topAnchor, constant: -24.widthDependent()),
            buttonFour.trailingAnchor.constraint(equalTo: buttonOne.leadingAnchor, constant: -24.widthDependent())
        ])
    }
}
