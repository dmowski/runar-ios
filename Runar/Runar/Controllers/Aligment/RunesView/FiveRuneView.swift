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
            buttonOne.leadingAnchor.constraint(equalTo: buttonFour.trailingAnchor, constant: -68.widthDependent()),
            buttonOne.topAnchor.constraint(equalTo: buttonFour.bottomAnchor, constant: 24.widthDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
            buttonOne.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonTwo.trailingAnchor.constraint(equalTo: buttonThree.leadingAnchor, constant: -116.widthDependent()),
            buttonTwo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonTwo.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonTwo.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
            
            buttonThree.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -81.widthDependent()),
            buttonThree.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonThree.leadingAnchor.constraint(equalTo: buttonThree.trailingAnchor, constant: -68.widthDependent()),
            buttonThree.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
            
            buttonFour.leadingAnchor.constraint(equalTo: buttonFour.trailingAnchor, constant: -68.widthDependent()),
            buttonFour.bottomAnchor.constraint(equalTo: buttonFour.topAnchor, constant: 90.widthDependent()),
            buttonFour.topAnchor.constraint(equalTo: self.topAnchor, constant: 194.widthDependent()),
            buttonFour.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
