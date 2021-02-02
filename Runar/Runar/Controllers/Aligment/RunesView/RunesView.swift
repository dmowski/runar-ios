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
    
    private var runeLayout: RuneLayout = .dayRune
    
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
        setupViewConstraints()
        setRuneLayout(.dayRune)
    }
    
    private func addSubviews() {
        enumeratedRuneViews.forEach {
            addSubview($0.value)
        }
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate(
            enumeratedRuneViews.flatMap { _, runeView -> [NSLayoutConstraint] in
                runeView.translatesAutoresizingMaskIntoConstraints = false
                
                return [
                    runeView.topAnchor.constraint(equalTo: topAnchor),
                    runeView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    runeView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    runeView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ]
            }
        )
    }
    
    //-------------------------------------------------
    // MARK: -
    //-------------------------------------------------
    
    public func setRuneLayout(_ runeLayout: RuneLayout) {
        enumeratedRuneViews.forEach { $0.value.isHidden = true }
        enumeratedRuneViews[runeLayout]?.isHidden = false
        
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
        
        selectedRuneView.openHighlightedButton()
        selectedRuneView.highlightNextButton()
        selectedRuneView.verifyDidHighlightAllButtons()
    }
}
