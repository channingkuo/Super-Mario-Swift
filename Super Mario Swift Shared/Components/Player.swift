//
//  Player.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player: SKSpriteNode {
    
    fileprivate final let maxWalkVelocity: Double = 6.0
    fileprivate final let maxRunVelocity: Double = 12
    fileprivate final let walkAcceleration: Double = 5
    
//    fileprivate final let runAcceleration: Double = 0.3
//    fileprivate final let turnAcceleration: Double = 0.35
//    fileprivate final let jumpVelocity: Double = -10.5

//    fileprivate var playerAction = false
    
    fileprivate var key: String = ""
    
    fileprivate var velocity: Velocity = Velocity()
//    fileprivate var acceleration: Double = 0.0
    
    fileprivate var previousTimeInterval: TimeInterval = 0
    fileprivate var playerIsFacingRight = true
    
    fileprivate var playerStateMachine: GKStateMachine!
    
    init(texture: SKTexture) {
        super.init(texture: texture, color: .black, size: texture.size())
        
        // starting position
        self.position = CGPoint(x: 146, y: 85)
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let physicsBody = SKPhysicsBody(rectangleOf: texture.size())
        physicsBody.allowsRotation = false
        self.physicsBody = physicsBody
        self.zPosition = 10000
        
        velocity = Velocity(xVelocity: 0.0, yVelocity: 0.0)
        
        playerStateMachine = GKStateMachine(states: [
            JumpingState(player: self),
            LandingState(player: self),
            WalkingState(player: self),
            IdleState(player: self),
            SlowingState(player: self)
        ])
        
        playerStateMachine.enter(IdleState.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAction(_ key: String) {
        self.key = key
        switch key {
        case Constants.BUTTON_LEFT:
            self.velocity.x = -walkAcceleration
            playerStateMachine.enter(WalkingState.self)
            break
        case Constants.BUTTON_RIGHT:
            self.velocity.x = walkAcceleration
            playerStateMachine.enter(WalkingState.self)
            break
        case Constants.BUTTON_DOWN:
            // 下蹲，纹理变换Action
            break
        case Constants.BUTTON_A:
            playerStateMachine.enter(JumpingState.self)
            break
        default:
            break
        }
    }
    
    func endAction(_ key: String) {
//        self.key = ""
//        switch key {
//        case Constants.BUTTON_LEFT:
//            self.velocity.x = 0
//            break
//        case Constants.BUTTON_RIGHT:
//            self.velocity.x = 0
//            break
//        case Constants.BUTTON_DOWN:
//            // 下蹲，纹理变换Action
//            break
//        default:
//            break
//        }
    }
    
    func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
        
        let displacement = CGVector(dx: deltaTime * self.velocity.x * 50, dy: 0)
        let move = SKAction.move(by: displacement, duration: 0)
        
        let faceAction: SKAction!
        if key.elementsEqual(Constants.BUTTON_LEFT) && playerIsFacingRight {
            playerIsFacingRight = false
            let faceMovement = SKAction.scaleX(to: -1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        }
        else if key.elementsEqual(Constants.BUTTON_RIGHT) && !playerIsFacingRight {
            playerIsFacingRight = true
            let faceMovement = SKAction.scaleX(to: 1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        }
        else {
            faceAction = move
        }
        self.run(faceAction)
    }
    
//    func calculateWalkVelocity(deltaTime: TimeInterval) {
//        let velocityT = self.velocity.x + self.acceleration * deltaTime
//
//        if velocityT >= maxWalkVelocity {
//            self.velocity.x = maxWalkVelocity
//        } else if velocityT <= -maxWalkVelocity {
//            self.velocity.x = -maxWalkVelocity
//        } else {
//            print("velocityT: \(velocityT)")
//            print("acceleration: \(self.acceleration)")
//            self.velocity.x = velocityT
//        }
//    }
    
    class func buildPlayer() -> Player {
        return Player(texture: SKTexture(imageNamed: "player_type_1_1"))
    }
}
