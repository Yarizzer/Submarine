//
//  Enemy.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 23/04/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//
import UIKit
import SpriteKit

final class EnemyUnit_1: SKSpriteNode {
    var leftwardTetxuresArray = [SKTexture]()
    var rightwardTetxuresArray = [SKTexture]()
//    static var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "EnemyUnit1")
    let texturesStrides = [(5, 1, -1), (5, 9, 1)]
    
    func moveSpiral() {
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 2
        let timeVertical: Double = 5
        
        let randomVal = Int(arc4random_uniform(2))
        
        
        let movingLeftAction = SKAction.animate(with: leftwardTetxuresArray, timePerFrame: 0.1, resize: true, restore: false)
        let movingBackLeftAction = SKAction.animate(with: leftwardTetxuresArray.reversed(), timePerFrame: 0.2, resize: true, restore: false)
        let moveLeftAnimation = SKAction.sequence([movingLeftAction, movingBackLeftAction])
        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut
        let groupLeftMovementAction = SKAction.group([moveLeftAnimation, moveLeft])
        
        
        let movingRightAction = SKAction.animate(with: rightwardTetxuresArray, timePerFrame: 0.1, resize: true, restore: false)
        let movingBackRightAction = SKAction.animate(with: rightwardTetxuresArray.reversed(), timePerFrame: 0.2, resize: true, restore: false)
        let moveRightAnimation = SKAction.sequence([movingRightAction, movingBackRightAction])
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        let groupRightMovementAction = SKAction.group([moveRightAnimation, moveRight])
        
        let asideMovementSequence = randomVal == 0 ? SKAction.sequence([groupLeftMovementAction, groupRightMovementAction]) : SKAction.sequence([groupRightMovementAction, groupLeftMovementAction])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        
        self.run(groupMovement)
        
    }

    fileprivate func fillTexturesArraysWithStrides() {
        for i in 0...1 {
            fillTexturesArrays(_stride: texturesStrides[i], index: i)
        }
    }
    
    fileprivate func fillTexturesArrays(_stride: (Int, Int, Int), index: Int) {
        var array = [SKTexture]()
        for i in stride(from: _stride.0, through: _stride.1, by: _stride.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "EnemyUnit_1_test_\(number)")
            array.append(texture)
        }
        switch index {
        case 0: self.leftwardTetxuresArray = array
        case 1: self.rightwardTetxuresArray = array
        default: break
        }
        SKTexture.preload(array) {
            print("preload is done")
        }
    }
    
    init() {
        let atlas = Assets.shared.submarineTexturesAtlas
        let texture = atlas.textureNamed("EnemyUnit_1_test_05")
        super.init(texture: texture, color: .clear, size: CGSize(width: 250, height: 250))
        self.xScale = 0.5
        self.yScale = 0.5
        self.zPosition = 20
        self.name = "enemySprite"
        self.fillTexturesArraysWithStrides()
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue

        
//        let shieldNode = EnemyUnit_1Shield()
//        self.addChild(shieldNode)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been emplemented")
    }
}
