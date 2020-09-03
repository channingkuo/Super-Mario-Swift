//
//  Player.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    fileprivate var state: PlayerStatesEnum!
    
    init(texture: SKTexture?) {
        super.init(texture: texture, color: .black, size: texture!.size())
        
        self.texture = texture
        self.position = CGPoint(x: 100, y: 100)
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.physicsBody = SKPhysicsBody(texture: texture!, size: texture!.size())
        self.zPosition = 10000
        
        state = .stand
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class func buildPlayer() -> Player {
        return Player(texture: SKTexture(imageNamed: "player_type_1_1"))
    }
}
