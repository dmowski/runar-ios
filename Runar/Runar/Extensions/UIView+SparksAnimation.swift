//
//  UIView+SparksAnimation.swift
//  Runar
//
//  Created by Kyzu on 23.09.22.
//

import UIKit
import SpriteKit

extension UIView {
    func startSparksAnimation(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        let skView = SKView()
        skView.backgroundColor = .clear
        addSubview(skView)
        skView.snp.makeConstraints { make in
            make.top.equalTo(snp_topMargin).offset(top)
            make.left.equalTo(snp_leftMargin).offset(left)
            make.right.equalTo(snp_rightMargin).offset(right)
            make.bottom.equalTo(snp_bottomMargin).offset(bottom)
        }
        let particleScene = SparksScene(size: frame.size)
        particleScene.backgroundColor = .clear
        particleScene.scaleMode = .resizeFill
        skView.presentScene(particleScene)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            skView.removeFromSuperview()
        }
    }
}
