//
//  Plant.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 01.04.2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Plant: SKSpriteNode, GameBackgroundSpritable {
    
    static func populate(at point: CGPoint?) -> Plant {
        
        let plantTextureName = configureName()
        let plant = Plant(imageNamed: plantTextureName)
        plant.setScale(randomScale)
        plant.position = point ?? randomPoint()
        plant.zPosition = 2
        plant.name = "BackgroundSprite"
        plant.run(move(from: plant.position))
        
        return plant
    }
    
    fileprivate static var randomScale: CGFloat {
        return CGFloat(getRandomValue(frtsVal: 5, scndVal: 10)) / 10
    }
    
    fileprivate static func configureName() -> String {
        return "texture_Plant_0\(getRandomValue(frtsVal: 1, scndVal: 3))"
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 50
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
    
    fileprivate static func getRandomValue(frtsVal: Int, scndVal: Int) -> Int {
        let distribution = GKRandomDistribution(lowestValue: frtsVal, highestValue: scndVal)
        return distribution.nextInt()
    }
}
