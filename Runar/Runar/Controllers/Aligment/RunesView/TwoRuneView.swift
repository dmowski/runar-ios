//
//  TwoRunView.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import UIKit
import Combine

class TwoRuneView: UIView, RuneViewProtocol {
    
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
        
        configureIndexesAndButtons(count: 2)
        addButtons()
        setupViewConstraints()
        highlightFirstButton()
    }
    
    private func setupViewConstraints() {
        guard
            let buttonOne = getButton(index: 0),
            let buttonTwo = getButton(index: 1)
            else {
            assertionFailure("Unexpected number of buttons. Expected number: 2. ExistingNumber: \(indexesAndButtons.count)")
            return
        }
        
        NSLayoutConstraint.activate([
            buttonOne.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 13.widthDependent()),
            buttonOne.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonOne.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 90.widthDependent()),

            buttonTwo.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -13.widthDependent()),
            buttonTwo.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonTwo.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonTwo.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
        ])
    }
}
