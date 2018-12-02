//
//  RedShot.swift
//  Submarine
//
//  Created by Yaroslav Abaturov on 12/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import SpriteKit

class RedShot: Shot {
    init() {
        let textureAtlas = Assets.shared.shot1Atlas
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
