//
//  Shot.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 12/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {
    let screenSize = UIScreen.main.bounds
    fileprivate let initialSize = CGSize(width: 220, height: 220)
    fileprivate let textureAtlas: SKTextureAtlas!
    var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        let texture = textureAtlas.textureNamed("Shot_01")
        super.init(texture: texture, color: .clear, size: initialSize)
        self.setScale(0.3)
        self.name = "Shot"
        self.zPosition = 30
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = BitMaskCategory.shot.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stertMoving() {
        for i in 1...25 {
            let number = String(format: "%02D", i)
            animationSpriteArray.append(SKTexture(imageNamed: "Shot_\(number)"))
            
        }
        
        SKTexture.preload(animationSpriteArray) { [unowned self] in
            let animation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.03, resize: true, restore: false)
            animation.timingMode = .easeIn
            let movingForward = SKAction.moveTo(y: self.screenSize.height + 100, duration: 2)
            movingForward.timingMode = .easeIn
            let shotAnimation = SKAction.group([animation, movingForward])
            self.run(shotAnimation)
        }
    }
}
