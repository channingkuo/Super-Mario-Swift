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
    
    fileprivate final let maxVelocity: Double = 500.0
    // fileprivate final let maxRunVelocity: Double = 12
    // fileprivate final let walkAcceleration: Double = 5
    
//    fileprivate final let runAcceleration: Double = 0.3
//    fileprivate final let turnAcceleration: Double = 0.35
//    fileprivate final let jumpVelocity: Double = -10.5

//    fileprivate var playerAction = false

    // player's speed info
    public var velocity: Velocity = Velocity()

    // controller key info
    fileprivate var directionKey: String = ""
    fileprivate var actionKey: String = ""

    // game loop timeinterval
    fileprivate var previousTimeInterval: TimeInterval = 0

    // player's StateMachine
    public var playerStateMachine: GKStateMachine!
    
    init(texture: SKTexture) {
        super.init(texture: texture, color: .black, size: texture.size())
        
        // starting position
        self.position = CGPoint(x: 146, y: 85)
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody.allowsRotation = false
        self.physicsBody = physicsBody
        self.zPosition = 10000
        
        velocity = Velocity(xVelocity: 0.0, yVelocity: 0.0)
        
        playerStateMachine = GKStateMachine(states: [
            IdleState(player: self),
            WalkingState(player: self),
            SlowingState(player: self),
            JumpingState(player: self),
            DeadState(player: self)
        ])
        
        playerStateMachine.enter(IdleState.self)
        
        print(self.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func keyDown(_ key: String) {
        let directionKeys = [Constants.BUTTON_LEFT, Constants.BUTTON_RIGHT, Constants.BUTTON_DOWN]
        let actionKeys = [Constants.BUTTON_A, Constants.BUTTON_B, Constants.BUTTON_X, Constants.BUTTON_Y]

        if directionKeys.contains(key) {
            self.directionKey = key
        }
        if actionKeys.contains(key) {
            self.actionKey = key
        }
    }

    func keyUp(_ key: String) {
        let directionKeys = [Constants.BUTTON_LEFT, Constants.BUTTON_RIGHT, Constants.BUTTON_DOWN]
        let actionKeys = [Constants.BUTTON_A, Constants.BUTTON_B, Constants.BUTTON_X, Constants.BUTTON_Y]

        if directionKeys.contains(key) {
            self.directionKey = ""
        }
        if actionKeys.contains(key) {
            self.actionKey = ""
        }
    }
    
    // func startAction(_ key: String) {
    //     self.key = key
    //     switch key {
    //     case Constants.BUTTON_LEFT:
    //         self.velocity.x = -walkAcceleration
    //         playerStateMachine.enter(WalkingState.self)
    //         break
    //     case Constants.BUTTON_RIGHT:
    //         self.velocity.x = walkAcceleration
    //         playerStateMachine.enter(WalkingState.self)
    //         break
    //     case Constants.BUTTON_DOWN:
    //         // 下蹲，纹理变换Action
    //         break
    //     case Constants.BUTTON_A:
    //         playerStateMachine.enter(JumpingState.self)
    //         break
    //     default:
    //         break
    //     }
    // }
    
    // func endAction(_ key: String) {
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
    // }
    
    func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - previousTimeInterval
        // 30fps
//        deltaTime = deltaTime * 2
        previousTimeInterval = currentTime
        
        print(deltaTime)
        
        switch self.directionKey {
        case Constants.BUTTON_LEFT:
            // TODO 设置加速度值，加速度小于零
            self.velocity.a_x = -200
            
            calculateXVelocity(deltaTime: deltaTime)
            
            // 判断player面向
            if self.velocity.v_x <= 0 {
                // 在地面上才会进入行走状态
                if self.action(forKey: "Sprite Animation") == nil && self.position.y <= 90 {
                    playerStateMachine.enter(WalkingState.self)
                }
                
                let displacement = CGVector(dx: deltaTime * self.velocity.v_x, dy: 0)
                let move = SKAction.move(by: displacement, duration: 0)
                let faceMovement = SKAction.scaleX(to: -1, duration: 0.0)
                
                self.run(SKAction.sequence([move, faceMovement]))
            } else if self.velocity.v_x > 0 {
                // 急刹车减速
                playerStateMachine.enter(SlowingState.self)
                let faceMovement = SKAction.scaleX(to: -1, duration: 0.0)
                self.run(faceMovement)
            }
            break
        case Constants.BUTTON_RIGHT:
            // 设置加速度值，加速度大于零
            self.velocity.a_x = 2000
            print(self.position)
            
            calculateXVelocity(deltaTime: deltaTime)
            
            // 判断player面向
            if self.velocity.v_x >= 0 {
                // 在地面上才会进入行走状态
                if self.action(forKey: "Sprite Animation") == nil && self.position.y <= 90  {
                    playerStateMachine.enter(WalkingState.self)
                }
                
                let displacement = CGVector(dx: deltaTime * self.velocity.v_x, dy: 0)
                let move = SKAction.move(by: displacement, duration: 0)
                let faceMovement = SKAction.scaleX(to: 1, duration: 0.0)
                
                self.run(SKAction.sequence([move, faceMovement]))
            } else if self.velocity.v_x < 0 {
                // 急刹车减速
                playerStateMachine.enter(SlowingState.self)
                let faceMovement = SKAction.scaleX(to: 1, duration: 0.0)
                self.run(faceMovement)
            }
            break
        case Constants.BUTTON_DOWN:
            
            break
        case "":
            // TODO 方向键松开，减速直至到站立状态
            
            break
        default: break
        }
        
//        let displacement = CGVector(dx: deltaTime * self.velocity.x * 50, dy: 0)
//        let move = SKAction.move(by: displacement, duration: 0)
//
//        let faceAction: SKAction!
//        if key.elementsEqual(Constants.BUTTON_LEFT) && playerIsFacingRight {
//            playerIsFacingRight = false
//            let faceMovement = SKAction.scaleX(to: -1, duration: 0.0)
//            faceAction = SKAction.sequence([move, faceMovement])
//        }
//        else if key.elementsEqual(Constants.BUTTON_RIGHT) && !playerIsFacingRight {
//            playerIsFacingRight = true
//            let faceMovement = SKAction.scaleX(to: 1, duration: 0.0)
//            faceAction = SKAction.sequence([move, faceMovement])
//        }
//        else {
//            faceAction = move
//        }
//        self.run(faceAction)
    }
    
    func calculateXVelocity(deltaTime: TimeInterval) {
        // self.maxVelocity 左右缓冲5速度
        if self.maxVelocity - 5 <= self.velocity.v_x {
            self.velocity.v_x = self.maxVelocity
        } else if -self.maxVelocity + 5 >= self.velocity.v_x {
            self.velocity.v_x = -self.maxVelocity
        } else {
            self.velocity.v_x = self.velocity.v_x + self.velocity.a_x * deltaTime
        }
    }
    
    class func buildPlayer() -> Player {
        return Player(texture: SKTexture(imageNamed: "player_type_1_1"))
    }
}

