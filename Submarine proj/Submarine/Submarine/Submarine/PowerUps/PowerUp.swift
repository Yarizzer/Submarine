//
//  PowerUp.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 18/04/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit
import SpriteKit

class PowerUp: SKSpriteNode {
    let initialSize = CGSize(width: 52, height: 52)
    let textureAtlas = Assets.shared.powerUpAtlas
    var animationSpriteArray = [SKTexture]()
    var backwardAnimationSpriteArray = [SKTexture]()
    
    
    init() {
        
        let texture = textureAtlas.textureNamed("texture_PowerUp_01")
        super.init(texture: texture, color: .clear, size: initialSize)
        self.setScale(0.2)
        self.name = "PowerUp"
        self.zPosition = 20
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.powerUp.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performTransform() {
        for i in 1...10 {
            let number = String(format: "%02D", i)
            animationSpriteArray.append(SKTexture(imageNamed: "texture_PowerUp_\(number)"))
            
        }
        for i in 2...9 {
            let number = String(format: "%02D", 11 - i)
            animationSpriteArray.append(SKTexture(imageNamed: "texture_PowerUp_\(number)"))
        }
        
        SKTexture.preload(animationSpriteArray) { [unowned self] in
            let animation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            let transformForever = SKAction.repeatForever(animation)
            self.run(transformForever)
        }
    }
}
