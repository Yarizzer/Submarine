//
//  PlayerSubmarine.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 09.04.2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit
import CoreMotion

class PlayerSubmarine: SKSpriteNode {

    fileprivate let motionManager = CMMotionManager()
    fileprivate var xAcceleration: CGFloat = 0.0
    fileprivate var moveDirection: TurnDirections = .none
    fileprivate var stillTurning = false
    fileprivate var yAcceleration: CGFloat = 0.0
    fileprivate let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    
    let texturesStrides = [(18, 5, -1), (18, 30, 1), (18, 18, 1)]
    var leftwardTexturesArray = [SKTexture]()
    var rightwardTexturesArray = [SKTexture]()
    var forwardTexturesArray = [SKTexture]()
    
    static func populate(at point: CGPoint) -> PlayerSubmarine {
        let playerSubmarineTexture = SKTexture(imageNamed: "SubmarineUnit_18")
        
        let playerSubmarine = PlayerSubmarine(texture: playerSubmarineTexture)
        playerSubmarine.setScale(0.3)
        playerSubmarine.position = point
        playerSubmarine.zPosition = 40
        
        playerSubmarine.physicsBody = SKPhysicsBody(texture: playerSubmarineTexture, alphaThreshold: 0.5, size: playerSubmarine.size)
        playerSubmarine.physicsBody?.isDynamic = false
        playerSubmarine.physicsBody?.categoryBitMask = BitMaskCategory.player.rawValue
        playerSubmarine.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerUp.rawValue
        playerSubmarine.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerUp.rawValue

        return playerSubmarine
    }
    
    func checkPosition() {
        self.position.x += xAcceleration * 50
        self.position.y += yAcceleration * 50
        if self.position.x < 10 {
            self.position.x =  10
        } else if self.position.x > screenSize.width - 10 {
            self.position.x = screenSize.width - 10
        }
        if self.position.y < 30 {
            self.position.y = 30
        } else if self.position.y > screenSize.height - 30 {
            self.position.y = screenSize.height - 30
        }
    }
    
    func performSwim() {
        preloadTextureArrays()
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {[unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.3 + self.xAcceleration * 0.1
                self.yAcceleration = CGFloat(acceleration.y + 0.75) * 0.5 + self.xAcceleration * 0.1
            }
        }
    
        let submarineWaitAction = SKAction.wait(forDuration: 0.1)
        let submarineDirectionCkeckAction = SKAction.run { [unowned self] in
            self.movementDirectionCheck()
        }
        let submarineSequence = SKAction.sequence([submarineWaitAction, submarineDirectionCkeckAction])
        let submarineSequenceForever = SKAction.repeatForever(submarineSequence)
        self.run(submarineSequenceForever)
        
    }
    
    fileprivate func preloadTextureArrays() {
        for i in 0...2 {
            self.preloadArray(_stride: texturesStrides[i]) { [unowned self] (array) in
                switch i {
                case 0: self.leftwardTexturesArray = array
                case 1: self.rightwardTexturesArray = array
                case 2: self.forwardTexturesArray = array
                default: break
                }
            }
        }
    }
    
    fileprivate func preloadArray(_stride: (Int, Int, Int), callback: @escaping (_ array: [SKTexture]) -> ()) {
        var array = [SKTexture]()
        for i in stride(from: _stride.0, through: _stride.1, by: _stride.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "SubmarineUnit_\(number)")
            array.append(texture)
        }
        SKTexture.preload(array) {
            callback(array)
        }
    }

 
    fileprivate func movementDirectionCheck() {
        
        if xAcceleration > 0.02, moveDirection != .right, stillTurning == false {
            stillTurning = true
            moveDirection = .right
            turnSubmarine(with: moveDirection)
        } else if xAcceleration < -0.02, moveDirection != .left, stillTurning == false {
            stillTurning = true
            moveDirection = .left
            turnSubmarine(with: moveDirection)
        } else if stillTurning == false {
            
        }
    }
    
    fileprivate func turnSubmarine(with direction: TurnDirections) {
        
        var array = [SKTexture]()
        switch direction {
        case .left:
            array = leftwardTexturesArray
        case .right:
            array = rightwardTexturesArray
        case .none:
            array = forwardTexturesArray
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.035, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.025, resize: true, restore: false)
        let sequnceAction = SKAction.sequence([forwardAction, backwardAction])
        
        self.run(sequnceAction) {[unowned self] in
            self.stillTurning = false
        }
    }
}

enum TurnDirections {
    case left
    case right
    case none
}











