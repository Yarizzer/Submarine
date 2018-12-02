//
//  MenuScene.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 12/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        let texture = SKTexture(imageNamed: "play")
        let button = SKSpriteNode(texture: texture)
        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        button.name = "runButton"
        self.addChild(button)
        Assets.shared.preloadAssets()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.previousLocation(in: self)
        let node = self.atPoint(location)
        if node.name == "runButton" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
    }
}
