//
//  Shell.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 04/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Shell: SKSpriteNode, GameBackgroundSpritable {
    static func populate(at point: CGPoint?) -> Shell {
        let shellTextureName = configureName()
        let shell = Shell(imageNamed: shellTextureName)
        shell.setScale(randomScale)
        shell.position = randomPoint()
        shell.zPosition = 2
        shell.name = "BackgroundSprite"
        shell.run(rotateShellForRandomAngle())
        shell.run(move(from: shell.position))
        
        return shell
    }
    
    fileprivate static func configureName() -> String {
        return "textureShell_0\(getRandomValue(frtsVal: 1, scndVal: 2))"
    }
    
    fileprivate static var randomScale: CGFloat {
        return CGFloat(getRandomValue(frtsVal: 20, scndVal: 30)) / 50
    }
    fileprivate static var direction: CGFloat {
        return CGFloat(getRandomValue(frtsVal: 10, scndVal: 360)) * CGFloat(Double.pi / 180)
    }
    fileprivate static func getRandomValue(frtsVal: Int, scndVal: Int) -> Int{
        let distribution = GKRandomDistribution(lowestValue: frtsVal, highestValue: scndVal)
        return distribution.nextInt()
    }
    fileprivate static func rotateShellForRandomAngle() -> SKAction {
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
