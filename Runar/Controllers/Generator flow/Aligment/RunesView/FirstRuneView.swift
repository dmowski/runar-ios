//
//  FirstRunView.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import Combine
import UIKit

public class FirstRuneView: UIView, RuneViewProtocol {    

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
        configureIndexesAndButtons(count: 1, availableRunes: RuneType.allCases(subtype: .random))
        addButtons()
        setupViewConstraints()
        highlightFirstButton()
    }
    
    private func setupViewConstraints() {
        guard let buttonOne = getButton(index: 0) else { return }
        
        NSLayoutConstraint.activate([
            buttonOne.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonOne.centerYAnchor.constraint(equalTo: centerYAnchor),

            buttonOne.widthAnchor.constraint(equalToConstant: 76.heightDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 100.heightDependent()),
            
            buttonOne.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            buttonOne.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            buttonOne.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            buttonOne.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])
    }
}
