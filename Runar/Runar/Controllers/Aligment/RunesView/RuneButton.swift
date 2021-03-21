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
        public let runeType: RuneType
        public let title: String
        public let image: UIImage
        public var openRune: (()->())
        public var runeInfo: ((_ runeType: RuneType)->())
        public func getAttributedTitle(with color: UIColor) -> NSAttributedString {
            NSAttributedString(
                string: title,
                attributes: [

                    .font: FontFamily.AmaticSC.bold.font(size: 50.heightDependent()),

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
    var runeType: RuneType? {
        viewModel?.runeType
    }
    private var darkImage = UIImageView()
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

            layer.borderWidth = Constants.BorderWidth.tinted.heightDependent()

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

            layer.borderWidth = Constants.BorderWidth.highlighted.heightDependent()

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
            isUserInteractionEnabled = true
            setAttributedTitle(nil, for: .normal)
            setImage(viewModel?.image, for: .normal)

            imageEdgeInsets = UIEdgeInsets(top: 105.heightDependent(), left: 83.heightDependent(), bottom: 105.heightDependent(), right: 83.heightDependent())
        }
        
        self.runeState = runeState
    }
    
    
    //-------------------------------------------------
    // MARK: -  Button animation
    //-------------------------------------------------
    
    
    private func animateButtonTap(completion: @escaping (Bool) -> ()) {
            UIView.animate(withDuration: 0.05, delay: 0.0, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: {
                (value: Bool) in
                completion(value)
            })
        }
        
        private func animateButtonDown(completion: @escaping (Bool) -> ()) {
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: [.allowUserInteraction, .curveEaseOut], animations: {
                self.transform = CGAffineTransform.identity
            }, completion: {
                (value: Bool) in
                completion(value)
            })
        }
        
        public func animateButton(completion: @escaping (Bool) -> ())  {
            animateButtonTap(completion: { [weak self] _ in
                self?.animateButtonDown(completion: completion)
            })
        }
    
    func addDark() {
        darkImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        darkImage.image = UIImage(named: "darkRune")
        self.addSubview(darkImage)
    }
    
    
    func removeDark(){
        darkImage.removeFromSuperview()
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
        switch self.runeState {
        case .highlighted:
            self.viewModel?.openRune()
        case .rune:
            guard let runeType = runeType else {return }
            self.viewModel?.runeInfo(runeType)

        default:
             break
        }
    
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


