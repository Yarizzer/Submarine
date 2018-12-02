//
//  EnemyUnit_1Shield.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 08/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit
import SpriteKit

final class EnemyUnit_1Shield: SKSpriteNode {
    let initialSize = CGSize(width: 250, height: 250)
//    let textureAtlas = SKTextureAtlas(named: "EnemyUnit1Shield")
    var animationTexturesArray = [SKTexture]()
    
    fileprivate func preloadTextures() {
        for i in 1...6 {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "EnemyUnit_1_shield_test_\(number)")
            animationTexturesArray.append(texture)
        }
        SKTexture.preload(animationTexturesArray) { [unowned self] in
            let animation = SKAction.animate(with: self.animationTexturesArray, timePerFrame: 0.05, resize: true, restore: false)
            let animationForever = SKAction.repeatForever(animation)
            self.run(animationForever)
        }
    }
    
    init() {
        let atlas = Assets.shared.enemyUnit1ShieldAtlas
        let texture = atlas.textureNamed("EnemyUnit_1_shield_test_01")
        super.init(texture: texture, color: .clear, size: initialSize)
        self.xScale = 1
        self.yScale = 1
        self.zPosition = 20
        self.name = "enemySprite"
        self.preloadTextures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
