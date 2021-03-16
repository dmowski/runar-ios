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
    
    func configureIndexesAndButtons(count: Int, availableRunes: [RuneType])
    func addButtons()
    
    func highlightFirstButton()
    func highlightNextButton()
    func openHighlightedButton()
    
    func verifyDidHighlightAllButtons()
}


public extension RuneViewProtocol where Self: UIView {


    var areAllButtonsOpened: Bool {
        !indexesAndButtons.contains(where: { $0.value.runeState != .rune })
    }
    
    var lastOpenedIndexAndButton: (Int, RuneButton)? {
        indexesAndButtons
            .sorted(by: { $0.key < $1.key })
            .last(where: { $0.value.runeState == .rune })
    }
    
    var highlightedIndexAndButton: (Int, RuneButton)? {
        indexesAndButtons
            .sorted(by: { $0.key < $1.key })
            .first(where: { $0.value.runeState == .highlighted })
    }
    
    func tintAllButtons() {
        indexesAndButtons.forEach { $0.value.setRuneState(.tinted) }
    }
    
    func highlightNextButton(previousIndex: Int) {
        guard let buttonToHighlight = getButton(index: previousIndex + 1) else { return }
        
        buttonToHighlight.setRuneState(.highlighted)
    }
    
    func openButton(index: Int) {
        guard let buttonToOpen = getButton(index: index) else { return }
        
        buttonToOpen.setRuneState(.rune)
    }
}

public extension RuneViewProtocol where Self: UIView {
    func getButton(index: Int) -> RuneButton? {
        indexesAndButtons[index]
    }
    
    func configureIndexesAndButtons(count: Int, availableRunes: [RuneType] = RuneType.allCases()) {
        runesSet.removeAll()
        
        indexesAndButtons = (0..<count).reduce(into: [Int: RuneButton](), { dict, index in
            let availableRunes = availableRunes.filter { !runesSet.contains($0) }
            
            guard let associatedRune = availableRunes.randomElement() else {
                assertionFailure("availableRunes is empty")
                return
            }
            
            runesSet.append(associatedRune)
            let runeImage = associatedRune.image
            let button = RuneButton()
            button.layer.cornerRadius = 25.heightDependent()
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false

            button.update(with: .init(runeType: associatedRune,
                                      title: "\(index + 1)", image: runeImage,
                openRune: {
                self.openButton(index: index)
                self.highlightNextButton(previousIndex: index)
                self.verifyDidHighlightAllButtons()
                }, runeInfo: { runeType in
                
                    let oneRune = OneRuneViewController(runeType: runeType, runeTime: self.configureRuneTime(runeLayout: self.viewModel!.runeLayout, index:index))
                    
                guard let controller = self.viewModel?.viewController else {return}
                controller.addChild(oneRune)
                controller.view.addSubview(oneRune.view)
                oneRune.didMove(toParent: controller)
                oneRune.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    oneRune.view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor),
                    oneRune.view.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
                    oneRune.view.widthAnchor.constraint(equalTo: controller.view.widthAnchor),
                                                oneRune.view.heightAnchor.constraint(equalToConstant: controller.view.frame.height * 2 / 3)
                    
                ])
                oneRune.didMove(toParent: self.viewModel?.viewController)
            }))

            dict[index] = button
        })
    }
    
    func configureRuneTime(runeLayout: RuneLayout, index: Int) -> String {
        var result = String()
        switch (runeLayout, index) {
        case (.dayRune, 0):
            result = ""
        case (.twoRunes, 0):
            result = "Настоящее"
        case (.twoRunes, 1):
            result = "Силы, влияющие на вас"
        case (.norns, 0):
            result = "Общая ситуация"
        case (.norns, 1):
            result = "Проблема"
        case (.norns, 2):
            result = "Решение проблемы"
        case (.shortPrediction, 0):
            result = "Настоящее"
        case (.shortPrediction, 1):
            result = "Проблема"
        case (.shortPrediction, 2):
            result = "Решение"
        case (.shortPrediction, 3):
            result = "Результат"
        case (.thorsHummer, 0):
            result = "Прошлое"
        case (.thorsHummer, 1):
            result = "Ситуация в настоящее время"
        case (.thorsHummer, 2):
            result = "Ситуация в настоящее время"
        case (.thorsHummer, 3):
            result = "Будущее"
        case (.cross, 0):
            result = "Прошлое"
        case (.cross, 1):
            result = "Проблема"
        case (.cross, 2):
            result = "Результат"
        case (.cross, 3):
            result = "Помощь"
        case (.cross, 4):
            result = "Непреодолимая сила"
        case (.elementsCross, 0):
            result = "Настоящее"
        case (.elementsCross, 1):
            result = "Ваша сущность"
        case (.elementsCross, 2):
            result = "Вероятное будущее"
        case (.elementsCross, 3):
            result = "Проблема"
        case (.elementsCross, 4):
            result = "Ваша цель"
        case (.elementsCross, 5):
            result = "Трудности"
        case (.keltsCross, 0):
            result = "Настоящее, истинное положение вещей"
        case (.keltsCross, 1):
            result = "Прошлое"
        case (.keltsCross, 2):
            result = "Будущее"
        case (.keltsCross, 3):
            result = "Условия, на которые необходимо обратить внимание"
        case (.keltsCross, 4):
            result = "Причина трудностей"
        case (.keltsCross, 5):
            result = "Лучшее, чего можно ожидать"
        case (.keltsCross, 6):
            result = ""
        default: break
        }
        return result
    }
    
    func addButtons() {
        indexesAndButtons.forEach { _, button in
            addSubview(button)
        }
    }
    
    func highlightFirstButton() {
        assert(!indexesAndButtons.isEmpty, "IndexesAndButtons is empty")
        
        tintAllButtons()
        highlightNextButton(previousIndex: -1)
    }
    
    func highlightNextButton() {
        guard let lastOpenedButtonIndex = lastOpenedIndexAndButton?.0 else { return }
        
        highlightNextButton(previousIndex: lastOpenedButtonIndex)
    }
    
    func openHighlightedButton() {

        guard let highlightedButtonIndex = highlightedIndexAndButton?.0 else { return }
        openButton(index: highlightedButtonIndex)
 
    }

    

    func verifyDidHighlightAllButtons() {
        guard areAllButtonsOpened else { return }
        viewModel?.didHighlightAllRunes(runesSet)
    }
}
