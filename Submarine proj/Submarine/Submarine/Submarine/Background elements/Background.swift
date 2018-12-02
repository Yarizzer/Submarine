//
//  Background.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 01.04.2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
    fileprivate static let screen = UIScreen.main.bounds
    static func populateBackGround(at point: CGPoint?) -> Background {
        let startPoint = CGPoint(x: screen.width / 2, y: screen.height + (screen.height / 2))
        let background = Background(imageNamed: "texture_BackgroundSand")
        background.setScale(4.01)
        background.position = point ?? startPoint
        background.zPosition = 0
        background.name = "BackgroundSprite"
        background.run(move(from: background.position))
        
        return background
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let screen = UIScreen.main.bounds
        let movePoint = CGPoint(x: point.x, y: -screen.height)
        let moveDistance = point.y - movePoint.y
        let movementSpeed: CGFloat = 50
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
