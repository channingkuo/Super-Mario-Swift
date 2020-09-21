//
//  PlayerStateMachine.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/9/4.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import Foundation
import GameplayKit

fileprivate let characterAnimationKey = "Sprite Animation"

class PlayerState: GKState {
    unowned var player: SKNode
    
    init(player: SKNode) {
        self.player = player
        
        super.init()
    }
}

class IdleState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is SlowingState.Type:
            return false
        default:
            return true
        }
    }
    
    let texture = SKTexture(imageNamed: "player_type_1_1")
    lazy var action = { SKAction.animate(with: [texture], timePerFrame: 0.1) }()
    
    override func didEnter(from previousState: GKState?) {
        player.removeAction(forKey: characterAnimationKey)
        player.run(action, withKey: characterAnimationKey)
    }
}

class WalkingState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    let textures: Array<SKTexture> = (1..<5).map({ return "player_type_1_\($0)" }).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.1)) }()
    
    override func didEnter(from previousState: GKState?) {
        player.removeAction(forKey: characterAnimationKey)
        player.run(action, withKey: characterAnimationKey)
    }
}

class JumpingState: PlayerState {
    var hasFinishedJump: Bool = false
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        if hasFinishedJump && stateClass is LandingState.Type { return true }
        return true
    }
    
    let texture: SKTexture = SKTexture(imageNamed: "player_type_1_6")
    lazy var action = { SKAction.animate(with: [texture], timePerFrame: 0.1) }()
    
    override func didEnter(from previousState: GKState?) {
        player.removeAction(forKey: characterAnimationKey)
        player.run(action, withKey: characterAnimationKey)
        
        hasFinishedJump = false
        // TODO 跳起来的位置变换处理，曲线运动，空中受方向键影响的处理
        player.run(.move(by: CGVector(dx: 0.0, dy: 110), duration: 0.1))
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {(timer) in
            self.hasFinishedJump = true
        }
    }
}

class SlowingState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass is IdleState.Type { return false }
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }
}

class DeadState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        // TODO dead enter next game or game over
    }
}
