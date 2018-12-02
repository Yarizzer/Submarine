//
//  GameScene.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 01.04.2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    let screenSize = UIScreen.main.bounds
    var player: PlayerSubmarine!
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        runBackgroundUpdate()
        spawnPlants()
        spawnStones()
        spawnStars()
        spawnShells()
        spawnFishes()
        spawnSharks()

        spawnPowerUp()
        spawnEnemiesType1()
        spawnEnemiesType2()
    }
    
    fileprivate func runBackgroundUpdate() {
        let moveDistance = screenSize.height + (screenSize.height / 2) - screenSize.height
        let movementSpeed: CGFloat = 50
        let duration = moveDistance / movementSpeed
        let waitAction = SKAction.wait(forDuration: TimeInterval(duration))
        let addingNewBackgroundSpriteAction = SKAction.run {
            let background = Background.populateBackGround(at: nil)
            self.addChild(background)
        }
        let sequenceAction = SKAction.sequence([waitAction, addingNewBackgroundSpriteAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        self.run(repeatAction)
    }
    
    fileprivate func spawnEnemiesType1() {
        let waitAction = SKAction.wait(forDuration: 15)
        let runAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies(count: 1)
        }
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, runAction])))
    }
    
    fileprivate func spawnSpiralOfEnemies(count: Int) {
        let enemyTextureAtlas = Assets.shared.enemyUnit1Atlas
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas]) {
//            EnemyUnit_1.textureAtlas = enemyTextureAtlas
            let waitAction = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run({
                let enemy = EnemyUnit_1()
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 100)
                self.addChild(enemy)
                enemy.moveSpiral()
            })
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: count)
            self.run(repeatAction)
            
        }
    }
    
    fileprivate func spawnEnemiesType2() {
        let waitAction = SKAction.wait(forDuration: 5)
        let runAction = SKAction.run { [unowned self] in
            self.spawnType2Enemies(count: 1)
        }
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, runAction])))
    }
    
    fileprivate func spawnType2Enemies(count: Int) {
        let enemyTextureAtlas = Assets.shared.enemyUnit2Atlas
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas]) {
//            EnemyUnit_2.textureAtlas = enemyTextureAtlas
            let waitAction = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run({ [unowned self] in
                let enemy = EnemyUnit_2()
//                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 100)
                self.addChild(enemy)
            })
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: count)
            self.run(repeatAction)
            
        }
    }
    
    fileprivate func spawnPowerUp() {
        let powerUp = PowerUp()
        powerUp.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        powerUp.performTransform()
        self.addChild(powerUp)
    }
    
    fileprivate func spawnPlants() {
        let spawnPlantWait = SKAction.wait(forDuration: 3)
        let spawnPlantAction = SKAction.run {
            let plant = Plant.populate(at: nil)
            self.addChild(plant)
        }
        let spawnPlantSequence = SKAction.sequence([spawnPlantWait, spawnPlantAction])
        let spawnPlantsForever = SKAction.repeatForever(spawnPlantSequence)
        run(spawnPlantsForever)
    }
    
    fileprivate func spawnStones() {
        let spawnStoneWait = SKAction.wait(forDuration: 3)
        let spawnStoneAction = SKAction.run {
            let stone = Stone.populate(at: nil)
            self.addChild(stone)
        }
        let spawnStoneSequence = SKAction.sequence([spawnStoneWait, spawnStoneAction])
        let spawnStonesForever = SKAction.repeatForever(spawnStoneSequence)
        run(spawnStonesForever)
    }
    
    fileprivate func spawnShells() {
        let spawnShellWait = SKAction.wait(forDuration: 20)
        let spawnShellAction = SKAction.run {
            let shell = Shell.populate(at: nil)
            self.addChild(shell)
        }
        let spawnShellSequence = SKAction.sequence([spawnShellWait, spawnShellAction])
        let spawnShellForever = SKAction.repeatForever(spawnShellSequence)
        run(spawnShellForever)
    }
    
    fileprivate func spawnStars() {
        let spawnStarWait = SKAction.wait(forDuration: 15)
        let spawnStarAction = SKAction.run {
            let star = Star.populate(at: nil)
            self.addChild(star)
        }
        let spawnStarSequence = SKAction.sequence([spawnStarWait, spawnStarAction])
        let spawnStarsForever = SKAction.repeatForever(spawnStarSequence)
        run(spawnStarsForever)
    }
    
    fileprivate func spawnFishes() {
        let spawnFishWait = SKAction.wait(forDuration: 10)
        let spawnFishAction = SKAction.run {
            let fish = Fish.populate(at: nil, degreeValue: nil)
            self.addChild(fish)
        }
        let spawnFishSequence = SKAction.sequence([spawnFishWait, spawnFishAction])
        let spawnFishForever = SKAction.repeatForever(spawnFishSequence)
        run(spawnFishForever)
    }
    
    fileprivate func spawnSharks() {
        let spawnSharkWait = SKAction.wait(forDuration: 15)
        let spawnSharkAction = SKAction.run {
            let shark = Shark.populate(at: nil, degreeValue: nil)
            self.addChild(shark)
        }
        let spawnSharkSequence = SKAction.sequence([spawnSharkWait, spawnSharkAction])
        let spawnSharkForever = SKAction.repeatForever(spawnSharkSequence)
        run(spawnSharkForever)
    }
    
    fileprivate func configureStartScene() {
//        let sprite = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 100))
        //        sprite.position = CGPoint(x: 200, y: 200)
        //        self.addChild(sprite)
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let backgroundFirst = Background.populateBackGround(at: screenCenterPoint)
//        backgroundFirst.size = self.size
        self.addChild(backgroundFirst)
        let backgroundSecond = Background.populateBackGround(at: nil)
//        backgroundSecond.size = self.size
        self.addChild(backgroundSecond)
        
        let screen = UIScreen.main.bounds

        for _ in 1...3 {
            let fish = Fish.populate(at: CGPoint(x: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.width))),
                                                  y: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.height)))),
                                     degreeValue: GKRandomDistribution(lowestValue: 1, highestValue:  359).nextInt())
            self.addChild(fish)
        }
        
        for _ in 1...3 {
            let stone = Stone.populate(at: CGPoint(x: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.width))),
                                                 y: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.height)))))
            self.addChild(stone)
        }
        
        for _ in 1...3 {
            let plant = Plant.populate(at: CGPoint(x: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.width))),
                                                    y: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.height)))))
            self.addChild(plant)
        }

        for _ in 1...2 {

            let star = Star.populate(at: CGPoint(x: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.width))),
                                                y: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.height)))))
            self.addChild(star)
        }
        
        let shark = Shark.populate(at: CGPoint(x: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.width))),
                                               y: CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.height)))),
                                    degreeValue: GKRandomDistribution(lowestValue: 1, highestValue:  359).nextInt())
        self.addChild(shark)


        player = PlayerSubmarine.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        player.performSwim()
        self.addChild(player)
 
    }
    
    override func didSimulatePhysics() {
        player.checkPosition()
        
        enumerateChildNodes(withName: "BackgroundSprite") { (node, stop) in
//            if node.position.y == -self.screenSize.height     // needs to set [unowned self]
            if node.hasActions() == false {
                node.removeFromParent()
//                print("BackgroundSprite has been terminated")
            }
        }
        enumerateChildNodes(withName: "BackgroundAliveObject") { (node, stop) in
            if node.hasActions() == false {
                node.removeFromParent()
//                print("BackgroundAliveObject has been terminated")
            }
        }
        enumerateChildNodes(withName: "enemySprite") { (node, stop) in
            if node.position.y < -100 {
                node.removeFromParent()
//                print("enemySprite has been terminated")
            }
        }
        
        enumerateChildNodes(withName: "Shot") { (node, stop) in
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent()
                //                print("enemySprite has been terminated")
            }
        }
    }
    
    fileprivate func playerFire() {
        let shot = RedShot()
        shot.position = self.player.position
        shot.stertMoving()
        self.addChild(shot)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerFire()
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
        case [.enemy, .player]: print("enemy vs player")
        case [.powerUp, .player]: print("enemy vs player")
        case [.enemy, .shot]: print("enemy vs player")
        default: preconditionFailure("Unanable to detect collision category")
        }
        
        /*let bodyABitMask = contact.bodyA.categoryBitMask
        let bodyBBitMask = contact.bodyB.categoryBitMask
        
        let playerBitMask = BitMaskCategory.player
        let enemyBitMask = BitMaskCategory.enemy
        let shotBitMask = BitMaskCategory.shot
        let powerUpBitMask = BitMaskCategory.powerUp
        
        if bodyABitMask == playerBitMask && bodyBBitMask == enemyBitMask || bodyABitMask == enemyBitMask && bodyBBitMask == playerBitMask {
            print("enemy vs player")
        } else if bodyABitMask == playerBitMask && bodyBBitMask == powerUpBitMask || bodyABitMask == powerUpBitMask && bodyBBitMask == playerBitMask {
            print("player vs powerUp")
        } else if bodyABitMask == enemyBitMask && bodyBBitMask == shotBitMask || bodyABitMask == shotBitMask && bodyBBitMask == enemyBitMask {
            print("enemy vs shot")
        }*/
        
    }
    func didEnd(_ contact: SKPhysicsContact) {}
    
}








