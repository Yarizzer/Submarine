//
//  Shark.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 02.04.2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit
import GameplayKit

final class Shark: SKSpriteNode, AliveBackgroundElementsSpritable {
    static func populate(at point: CGPoint?, degreeValue: Int?) -> Shark {
        let sharkImageName = configureName()
        let shark = Shark(imageNamed: sharkImageName)
        shark.setScale(randomScale)
        shark.position = point ?? randomPoint()
        shark.zPosition = CGFloat(getRandomValue(frtsVal: 3, scndVal: 5))
        shark.name = "BackgroundAliveObject"
        let val = degreeValue ?? randomRange(currentPosition: shark.position)
        let sharkDirection = getDirection(lowestValue: val, highestValue: val)
        shark.run(rotateSharkForRandomAngle(angle: sharkDirection))
        shark.run(move(from: shark.position, with: sharkDirection))
        return shark
    }
    
    fileprivate static var randomScale: CGFloat {
        return CGFloat(getRandomValue(frtsVal: 5, scndVal: 10)) / 10
    }
    fileprivate static func getDirection(lowestValue: Int, highestValue: Int) -> CGFloat {
        return CGFloat(getRandomValue(frtsVal: lowestValue, scndVal: highestValue)) * CGFloat(Double.pi / 180)
    }
    fileprivate static func configureName() -> String {
        return "texture_Shark_0" + "\(getRandomValue(frtsVal: 1, scndVal: 3))"
    }
    fileprivate static func getRandomValue(frtsVal: Int, scndVal: Int) -> Int {
        let distribution = GKRandomDistribution(lowestValue: frtsVal, highestValue: scndVal)
        return distribution.nextInt()
    }
    fileprivate static func rotateSharkForRandomAngle(angle: CGFloat) -> SKAction {
        return SKAction.rotate(byAngle: angle, duration: 0)
    }
    fileprivate static func move(from point: CGPoint, with angle: CGFloat) -> SKAction {
        let screen = UIScreen.main.bounds
        
        var movePoint: CGPoint = CGPoint(x: 0, y: 0)
        let movementSpeed: CGFloat = 25
        var gip: CGFloat = 0.0
        let convertedToDegreeAngle = CGFloat(angle / (CGFloat(Double.pi) / 180))
        switch convertedToDegreeAngle {
        case 1..<90:
            let degree = 90 - (CGFloat(angle / (CGFloat(Double.pi) / 180)))
            let cat1 = point.x + 30
            let cat2 = cat1 * tan(degree * CGFloat(Double.pi / 180))
            gip = sqrt(pow(cat1, 2) + pow(cat2, 2))

            
            movePoint = CGPoint(x: -30, y: point.y + cat2)
        case 90:
            gip = point.x
            
            movePoint = CGPoint(x: -30, y: point.y)
        case 91..<180:
            let degree = (CGFloat(angle / (CGFloat(Double.pi) / 180))) - 90
            let cat1 = point.x + 30
            let cat2 = cat1 * tan(degree * CGFloat(Double.pi / 180))
            gip = sqrt(pow(cat1, 2) + pow(cat2, 2))
            
            movePoint = CGPoint(x: -30, y: point.y - cat2)
        case 180:
            gip = point.y
            movePoint = CGPoint(x: point.x, y: -30)
        case 181..<270:
            let degree = 270 - (CGFloat(angle / (CGFloat(Double.pi) / 180)))
            let cat1 = screen.width - point.x + 30
            let cat2 = cat1 * tan(degree * CGFloat(Double.pi / 180))
            gip = sqrt(pow(cat1, 2) + pow(cat2, 2))
            
            movePoint = CGPoint(x: screen.width + 30, y: point.y - cat2)
        case 270:
            gip = screen.width - point.x
            movePoint = CGPoint(x: screen.width + 30, y: point.y)
        case 271..<360:
            let degree = (CGFloat(angle / (CGFloat(Double.pi) / 180))) - 270
            let cat1 = screen.width - point.x + 30
            let cat2 = cat1 * tan(degree * CGFloat(Double.pi / 180))
            gip = sqrt(pow(cat1, 2) + pow(cat2, 2))
            
            movePoint = CGPoint(x: screen.width + 30, y: point.y + cat2)
        default:
            print("not supported degree value")
        }
        
        let backgroundElemensSpeed: CGFloat = 50.0
        let dur = gip / movementSpeed
        let offset = backgroundElemensSpeed * dur
        movePoint = CGPoint(x: movePoint.x, y: movePoint.y - offset)
        let duration = gip / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
