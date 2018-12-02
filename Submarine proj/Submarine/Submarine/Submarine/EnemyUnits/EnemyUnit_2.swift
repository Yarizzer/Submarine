//
//  EnemyUnit_2.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 10/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import GameplayKit

final class EnemyUnit_2: SKSpriteNode {
//    static var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "EnemyUnit1")
    init() {
        let screen = UIScreen.main.bounds
        let yDistribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 50, highestValue: Int(screen.size.height) + 100)
        let xDistribution = GKRandomDistribution(lowestValue: 10, highestValue: Int(screen.size.width) - 10)
        let atlas = Assets.shared.enemyUnit2Atlas
        let texture = atlas.textureNamed("EnemyUnit_2_test_5")
        super.init(texture: texture, color: .clear, size: CGSize(width: 150, height: 150))
        self.position.x = CGFloat(xDistribution.nextInt())
        self.position.y = CGFloat(yDistribution.nextInt())
        self.xScale = 0.5
        self.yScale = 0.5
        self.zPosition = 20
        self.name = "enemySprite"

        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue

        
        self.run(moving(from: CGPoint(x: self.position.x, y: self.position.y)))
//        let shieldNode = EnemyUnit_1Shield()
//        self.addChild(shieldNode)
    }

    fileprivate func getRandomValue(frtsVal: Int, scndVal: Int) -> Int {
        let distribution = GKRandomDistribution(lowestValue: frtsVal, highestValue: scndVal)
        return distribution.nextInt()
    }

    fileprivate func moving(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 150
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
