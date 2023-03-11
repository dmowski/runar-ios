//
//  CustomIntensityVisualEffectView.swift
//  Runar
//
//  Created by Sasza Niehaj on 3/11/23.
//

import UIKit

class CustomIntensityVisualEffectView: UIVisualEffectView {
    
    private var animator: UIViewPropertyAnimator?
    
    init(effect: UIVisualEffect, intensity: CGFloat) {
        super.init(effect: nil)
        
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [weak self] in
            self?.effect = effect
        }
        animator?.fractionComplete = intensity
        animator?.pausesOnCompletion = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
