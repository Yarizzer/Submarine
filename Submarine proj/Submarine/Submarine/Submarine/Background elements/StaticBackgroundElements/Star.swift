//
//  Star.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 01.04.2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit
import GameplayKit

final class Star: SKSpriteNode, GameBackgroundSpritable {
    //used for random generation of plants
    static func populate(at point: CGPoint?) -> Star {
        let starTextureName = configureName()
        let star = Star(imageNamed: starTextureName)
        star.setScale(randomScale)
        star.position = point ?? randomPoint()
        star.zPosition = 2
        star.name = "BackgroundSprite"
        star.run(rotateStarForRandomAngle())
        star.run(move(from: star.position))
        
        return star
    }
    
    fileprivate static var randomScale: CGFloat {
        return CGFloat(getRandomValue(frtsVal: 10, scndVal: 25)) / 50
    }
    fileprivate static var direction: CGFloat {
        return CGFloat(getRandomValue(frtsVal: 10, scndVal: 360)) * CGFloat(Double.pi / 180)
    }
    fileprivate static func configureName() -> String {
        return "texture_Star_0" + "\(getRandomValue(frtsVal: 1, scndVal: 3))"
    }
    fileprivate static func getRandomValue(frtsVal: Int, scndVal: Int) -> Int{
        let distribution = GKRandomDistribution(lowestValue: frtsVal, highestValue: scndVal)
        return distribution.nextInt()
    }
    fileprivate static func rotateStarForRandomAngle() -> SKAction {
        return SKAction.rotate(byAngle: direction, duration: 0)
    }
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 50
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
