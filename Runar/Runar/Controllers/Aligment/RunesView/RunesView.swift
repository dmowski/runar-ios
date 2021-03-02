//
//  RunesView.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import UIKit

public class RunesView: UIView {
    
    //-------------------------------------------------
    // MARK: - Nested types
    //-------------------------------------------------
    
    public class ViewModel {
        public let didHighlightAllRunes: ([RuneType]) -> Void
        
        public init(didHighlightAllRunes: @escaping ([RuneType]) -> Void) {
            self.didHighlightAllRunes = didHighlightAllRunes
        }
    }
    
    //-------------------------------------------------
    // MARK: - Variables
    //-------------------------------------------------
    
    var runeLayout: RuneLayout = .dayRune
    
    private let enumeratedRuneViews: [RuneLayout: RuneViewProtocol & UIView] = [
        .dayRune: FirstRuneView(),
        .twoRunes: TwoRuneView(),
        .norns: ThreeRuneView(),
        .shortPrediction: FourRuneView(),
        .thorsHummer: FiveRuneView(),
        .cross: SixRuneView(),
        .elementsCross: SevenRuneView(),
        .keltsCross: EightRuneView(),
    ]
    
    //-------------------------------------------------
    // MARK: - Methods
    //-------------------------------------------------
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupContent()
    }
    
    private func setupContent() {
        addSubviews()
        setRuneLayout(.dayRune)
    }
    
    private func addSubviews() {
        enumeratedRuneViews.forEach {
            addSubview($0.value)
        }
    }
    
    //-------------------------------------------------
    // MARK: -
    //-------------------------------------------------
    
    public func setRuneLayout(_ runeLayout: RuneLayout) {
        enumeratedRuneViews.forEach { $0.value.removeFromSuperview() }
        guard let chosenView = enumeratedRuneViews[runeLayout] else { return }
        chosenView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chosenView)
        
        NSLayoutConstraint.activate([
            chosenView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            chosenView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            chosenView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chosenView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        self.runeLayout = runeLayout
    }
    
    public func update(with model: ViewModel) {
        enumeratedRuneViews.forEach { $0.value.viewModel = model }
    }
    
    public func openHighlightedButton() {
            guard let selectedRuneView = enumeratedRuneViews[runeLayout] else {
                assertionFailure("There is no selected RuneView with layout: \(runeLayout)")
                return
            }
            
        guard let (_, highlightedButton) = selectedRuneView.highlightedIndexAndButton else { return }

            highlightedButton.animateButton(completion: { [weak selectedRuneView] _ in
            selectedRuneView?.openHighlightedButton()
            selectedRuneView?.highlightNextButton()
            selectedRuneView?.verifyDidHighlightAllButtons()
            })
        }
}
