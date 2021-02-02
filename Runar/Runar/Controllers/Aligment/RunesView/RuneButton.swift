//
//  ExtensionUIButton.swift
//  Runar
//
//  Created by Oleg Kanatov on 25.01.21.
//

import UIKit

public class RuneButton: UIButton {
    
    //-------------------------------------------------
    // MARK: - Nested types
    //-------------------------------------------------
    
    public struct ViewModel {
        public let title: String
        public let image: UIImage
        
        public func getAttributedTitle(with color: UIColor) -> NSAttributedString {
            NSAttributedString(
                string: title,
                attributes: [
                    .font: FontFamily.AmaticSC.bold.font(size: 50.widthDependent()),
                    .foregroundColor: color
                ]
            )
        }
    }
    
    public enum State {
        case tinted
        case highlighted
        case rune
    }
    
    //-------------------------------------------------
    // MARK: - Varibles
    //-------------------------------------------------
    
    private var viewModel: ViewModel?
    public private(set) var runeState: State = .tinted
    
    //-------------------------------------------------
    // MARK: - Methods
    //-------------------------------------------------
    
    public func update(with model: ViewModel) {
        self.viewModel = model
        setRuneState(runeState)
    }
    
    public func setRuneState (_ runeState: State) {
        switch runeState {
        case .tinted:
            clipsToBounds = true
            backgroundColor = Constants.BackgroundColor.tinted
            layer.borderColor = Constants.BorderColor.tinted.cgColor
            layer.borderWidth = Constants.BorderWidth.tinted.widthDependent()
            isUserInteractionEnabled = false
            setAttributedTitle(
                viewModel?.getAttributedTitle(with: Constants.TextColor.tinted),
                for: .normal
            )
            setImage(nil, for: .normal)
        case .highlighted:
            clipsToBounds = true
            backgroundColor = Constants.BackgroundColor.highlighted
            layer.borderColor = Constants.BorderColor.highlighted.cgColor
            layer.borderWidth = Constants.BorderWidth.highlighted.widthDependent()
            isUserInteractionEnabled = true
            setAttributedTitle(
                viewModel?.getAttributedTitle(with: Constants.TextColor.highlighted),
                for: .normal
            )
            setImage(nil, for: .normal)
        case .rune:
            clipsToBounds = false
            backgroundColor = .clear
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 0
            isUserInteractionEnabled = false
            setAttributedTitle(nil, for: .normal)
            setImage(viewModel?.image, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 105.widthDependent(), left: 83.widthDependent(), bottom: 105.widthDependent(), right: 83.widthDependent())
        }
        
        self.runeState = runeState
        
        //        backgroundColor = runeState.backgroundColor
        //        layer.borderColor = runeState.borderColor
        //        layer.borderWidth = runeState.borderWidth
        //        setTitleColor(runeState.textColor, for: .normal)
        //        self.runeState = runeState
    }
    
    //-------------------------------------------------
    // MARK: - Handle touch
    //-------------------------------------------------
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        transform = .identity
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        transform = .identity
    }
}

    //-------------------------------------------------
    // MARK: - Constants
    //-------------------------------------------------

private extension RuneButton {
    enum Constants {
        enum BackgroundColor {
            static let tinted = Assets.Colors.UnTouch.layerBackground.color
            static let highlighted = Assets.Colors.Touch.layerBackground.color
        }
        enum BorderColor {
            static let tinted = Assets.Colors.UnTouch.layerBorder.color
            static let highlighted = Assets.Colors.Touch.layerBorder.color
        }
        enum TextColor {
            static let tinted = Assets.Colors.UnTouch.text.color
            static let highlighted = Assets.Colors.Touch.text.color
        }
        enum BorderWidth {
            static let tinted = 1
            static let highlighted = 2
        }
    }
}

//private extension RuneButton.State {
//    var backgroundColor: UIColor {
//        switch self {
//        case .tinted:
//            return Assets.Colors.UnTouch.layerBackground.color
//        case .highlighted:
//            return Assets.Colors.Touch.layerBackground.color
//        case .rune:
//            return .clear
//        }
//    }
//    var borderColor: CGColor {
//        switch self {
//        case .tinted:
//            return Assets.Colors.UnTouch.layerBorder.color.cgColor
//        case .highlighted:
//            return Assets.Colors.Touch.layerBorder.color.cgColor
//        case .rune:
//            return UIColor.clear.cgColor
//        }
//    }
//    var textColor: UIColor {
//        switch self {
//        case .tinted:
//            return Assets.Colors.UnTouch.text.color
//        case .highlighted:
//            return Assets.Colors.Touch.text.color
//        case .rune:
//            return .clear
//        }
//    }
//    var borderWidth: CGFloat {
//        switch self {
//        case .tinted:
//            return 1
//        case .highlighted:
//            return 2
//        case .rune:
//            return 0
//        }
//    }
//}
