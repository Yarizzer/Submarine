//
//  protocol AliveBackgroundElementsSpritable + extension.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 10/04/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol AliveBackgroundElementsSpritable {
    static func populate(at point: CGPoint?,  degreeValue: Int?) -> Self
    static func randomPoint() -> CGPoint
    static func randomRange(currentPosition: CGPoint) -> Int
}

extension AliveBackgroundElementsSpritable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let side = GKRandomDistribution(lowestValue: 1, highestValue: 3).nextInt()
        var distributionX = 0
        var distributionY = 0
        if side == 1 {
            distributionX = GKRandomDistribution(lowestValue: -200, highestValue:  -100).nextInt()
            distributionY = GKRandomDistribution(lowestValue: 100, highestValue: Int(screen.size.height)).nextInt()
        } else if side == 2 {
            distributionX = GKRandomDistribution(lowestValue: 0, highestValue: Int(screen.size.width)).nextInt()
            distributionY = GKRandomDistribution(lowestValue: Int(screen.size.height) + 100, highestValue: Int(screen.size.height) + 200).nextInt()
        } else if side == 3 {
            distributionX = GKRandomDistribution(lowestValue: Int(screen.size.width) + 100, highestValue: Int(screen.size.width) + 200).nextInt()
            distributionY = GKRandomDistribution(lowestValue: 0, highestValue: Int(screen.size.height)).nextInt()
        }
        
        return CGPoint(x: distributionX, y: distributionY)
    }
    static func randomRange(currentPosition point: CGPoint) -> Int {
        let screen = UIScreen.main.bounds

        var value = 0
        
        if point.x < 0 {
            value = GKRandomDistribution(lowestValue: 230, highestValue:  310).nextInt()
        } else if point.x > screen.size.width {
            value = GKRandomDistribution(lowestValue: 50, highestValue:  130).nextInt()
        } else {
            value = GKRandomDistribution(lowestValue: 140, highestValue:  230).nextInt()
        }
        return value
    }
    
}
