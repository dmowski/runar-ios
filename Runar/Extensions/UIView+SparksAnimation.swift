//
//  UIView+SparksAnimation.swift
//  Runar
//
//  Created by Kyzu on 23.09.22.
//

import UIKit
import SpriteKit

extension UIView {
    func startSparksAnimation(frame: CGRect) {
        let skView = SKView()
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.backgroundColor = .clear
        self.addSubview(skView)
        skView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        skView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -5).isActive = true
        skView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        skView.heightAnchor.constraint(equalToConstant: self.frame.height + 50).isActive = true
        let particleScene = SparksScene(size: CGSize(width: self.frame.width, height: self.frame.height + 30))
        particleScene.backgroundColor = .clear
        particleScene.scaleMode = .resizeFill
        skView.presentScene(particleScene)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            skView.removeFromSuperview()
        }
    }
}
