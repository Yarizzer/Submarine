//
//  Assets.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 12/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit

class Assets {
    static let shared = Assets()
    let shot1Atlas = SKTextureAtlas.init(named: "Shot1")
    let enemyUnit1Atlas = SKTextureAtlas.init(named: "EnemyUnit1")
    let enemyUnit2Atlas = SKTextureAtlas.init(named: "EnemyUnit2")
    let enemyUnit1ShieldAtlas = SKTextureAtlas.init(named: "EnemyUnit1Shield")
    let powerUpAtlas = SKTextureAtlas.init(named: "PowerUp")
    let submarineTexturesAtlas = SKTextureAtlas.init(named: "SubmarineTextures")
    
    func preloadAssets() {
        shot1Atlas.preload {print ("shot1 atlas preloaded")}
        enemyUnit1Atlas.preload {print ("enemyUnit1Atlas atlas preloaded")}
        enemyUnit2Atlas.preload {print ("enemyUnit2Atlas atlas preloaded")}
        enemyUnit1ShieldAtlas.preload {print ("enemyUnit1ShieldAtlas atlas preloaded")}
        powerUpAtlas.preload {print ("powerUpAtlas atlas preloaded")}
        submarineTexturesAtlas.preload {print ("submarineTexturesAtlas atlas preloaded")}
    }
}
