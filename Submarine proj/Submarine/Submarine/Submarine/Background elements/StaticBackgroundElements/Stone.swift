//
//  Stone.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 03/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Stone: SKSpriteNode, GameBackgroundSpritable {
    static func populate(at point: CGPoint?) -> Stone {
        
        let stoneTextureName = configureName()
        let stone = Stone(imageNamed: stoneTextureName)
        stone.setScale(randomScale)
        stone.position = point ?? randomPoint()
        stone.zPosition = 1
        stone.name = "BackgroundSprite"
        stone.run(move(from: stone.position))
        
        return stone
    }
    
    fileprivate static func configureName() -> String {
        return "textureStone_0\(getRandomValue(frtsVal: 1, scndVal: 7))"
    }
    
    fileprivate static var randomScale: CGFloat {
        return CGFloat(getRandomValue(frtsVal: 10, scndVal: 20)) / 50
    }
    
    fileprivate static func getRandomValue(frtsVal: Int, scndVal: Int) -> Int{
        let distribution = GKRandomDistribution(lowestValue: frtsVal, highestValue: scndVal)
        return distribution.nextInt()
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 50
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
