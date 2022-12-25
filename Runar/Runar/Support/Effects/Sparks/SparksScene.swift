//
//  ParticleScene.swift
//  spriteBurn
//
//  Created by Kyzu on 22.09.22.
//

import Foundation
import SpriteKit

class SparksScene: SKScene {

    private var viewSize: CGSize

    override init(size: CGSize) {
        viewSize = size
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupParticleEmitter()
    }
    
    private func setupParticleEmitter() {
        let particleEmitter = SKEmitterNode(fileNamed: "SparksEffect")!
        particleEmitter.particleTexture = SKTexture(imageNamed: "spark")
        let fade_action = SKAction.fadeAlpha(to: 0.0, duration: 1)
        addChild(particleEmitter)
        let moveAction = SKAction.move(to: CGPoint(x: viewSize.width / 2, y: 0), duration: 0)
        particleEmitter.run(moveAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            particleEmitter.run(fade_action)
        }
    }
}
