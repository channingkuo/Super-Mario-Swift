//
//  Player.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    fileprivate final let maxWalkSpeed = 6
    fileprivate final let maxRunSpeed = 12
    fileprivate final let maxYVelocity = 11
    fileprivate final let walkAcceleration = 0.15
    fileprivate final let runAcceleration = 0.3
    fileprivate final let turnAcceleration = 0.35
    fileprivate final let jumpVelocity = -10.5
    
    fileprivate var state: PlayerStatesEnum!
    
    fileprivate var xVelocity: CGFloat = 0
    fileprivate var yVelocity: CGFloat = 0
    
    init(texture: SKTexture?) {
        super.init(texture: texture, color: .black, size: texture!.size())
        
        self.texture = texture
        self.position = CGPoint(x: 0, y: 200)
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.physicsBody = SKPhysicsBody(texture: texture!, size: texture!.size())
        self.physicsBody!.allowsRotation = false
        self.zPosition = 10000
        
        state = .stand
        xVelocity = 0
        yVelocity = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // calculate player's velocity
    func calculateVelocity() -> CGFloat {
        
        return 0
    }
    
    // calculate player's position
    func calculatePosition() -> CGPoint {
        let x = self.position.x + xVelocity
        let y = self.position.y + yVelocity
        return  CGPoint(x: x, y: y)
    }
    
    // update player
    func update() {
        <#function body#>
    }
    
    
    class func buildPlayer() -> Player {
        return Player(texture: SKTexture(imageNamed: "player_type_1_1"))
    }
}
