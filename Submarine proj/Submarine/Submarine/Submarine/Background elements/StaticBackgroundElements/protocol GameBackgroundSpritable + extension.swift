//
//  protocol GameBackgroundSpritable + extention.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 10/04/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpritable {
    static func populate(at point: CGPoint?) -> Self
    static func randomPoint() -> CGPoint
}

extension GameBackgroundSpritable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 50, highestValue: Int(screen.size.height) + 100)
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.width)))
        
        return CGPoint(x: x, y: y)
    }
}
