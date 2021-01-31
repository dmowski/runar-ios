//
//  RuneViewProtocol.swift
//  Runar
//
//  Created by Oleg Kanatov on 26.01.21.
//

import UIKit
import Combine

public protocol RuneViewProtocol: AnyObject {
    
    var viewModel: RunesView.ViewModel? { get set }
    
    var runesSet: [RuneType] { get set }
    var cancellables: [AnyCancellable] { get set }
    var indexesAndButtons: [Int: RuneButton] { get set }
    
    func getButton(index: Int) -> RuneButton?
    func configureIndexesAndButtons(count: Int)
    func addButtons()
    func highlightFirstButton()
    func openButton(index: Int)
    func highlightNextButton(previousIndex: Int) -> Bool
}

public extension RuneViewProtocol where Self: UIView {
    func getButton(index: Int) -> RuneButton? {
        indexesAndButtons[index]
    }
    
    func configureIndexesAndButtons(count: Int) {
        let availableRunes = RuneType.allCases
        runesSet.removeAll()
        
        indexesAndButtons = (0..<count).reduce(into: [Int: RuneButton](), { dict, index in
            let availableRunes = availableRunes.filter { !runesSet.contains($0) }
            
            guard let associatedRune = availableRunes.randomElement()?.any else {
                assertionFailure("availableRunes is empty")
                return
            }
            
            runesSet.append(associatedRune)
            let runeImage = associatedRune.image
            
            let button = RuneButton()
            button.layer.cornerRadius = 25.widthDependent()
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.update(with: .init(title: "\(index + 1)", image: runeImage))
            button.tapPublisher()
                .sink { [weak self, weak button] in
                    guard let self = self else { return }
                    
                    guard button?.runeState == .highlighted else { return }
                    self.openButton(index: index)
                    
                    guard !self.highlightNextButton(previousIndex: index) else { return }
                    self.viewModel?.didHighlightAllRunes(self.runesSet)
                }.store(in: &cancellables)
            dict[index] = button
        })
    }
    
    func addButtons() {
        indexesAndButtons.forEach { _, button in
            addSubview(button)
        }
    }
    
    func highlightFirstButton() {
        let isSuccessful = highlightNextButton(previousIndex: -1)
        if !isSuccessful {
            assertionFailure("Failed to highlight first button. IndexesAndButtons seems to be empty")
        }
    }
    
    func openButton(index: Int) {
        guard let buttonToOpen = getButton(index: index) else {
            assertionFailure("there is no button with index: \(index) in indexesAndButtons")
            return
        }
        buttonToOpen.setRuneState(.rune)
    }
    @discardableResult
    func highlightNextButton(previousIndex: Int) -> Bool {
        guard let buttonToHighlight = getButton(index: previousIndex + 1) else {
            return false
        }
        buttonToHighlight.setRuneState(.highlighted)
        return true
    }
}
