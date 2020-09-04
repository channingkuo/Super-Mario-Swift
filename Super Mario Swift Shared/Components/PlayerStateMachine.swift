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

class JumpingState: PlayerState {
    var hasFinishedJump: Bool = false
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        if hasFinishedJump && stateClass is LandingState.Type { return true }
        return true
    }
    
    let texture: SKTexture = SKTexture(imageNamed: "player_type_2_1")
    lazy var action = { SKAction.animate(with: [texture], timePerFrame: 0.1) }()
    
    override func didEnter(from previousState: GKState?) {
        player.removeAction(forKey: characterAnimationKey)
        player.run(action, withKey: characterAnimationKey)
        
        hasFinishedJump = false
        player.run(.move(by: CGVector(dx: 0.0, dy: 76), duration: 0.1))
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {(timer) in
            self.hasFinishedJump = true
        }
    }
}

class LandingState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is LandingState.Type, is JumpingState.Type, is SlowingState.Type:
            return false
        default:
            return true
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        stateMachine?.enter(IdleState.self)
    }
}

class WalkingState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is LandingState.Type, is WalkingState.Type, is SlowingState.Type:
            return false
        default:
            return true
        }
    }
    
    let textures: Array<SKTexture> = (1..<5).map({ return "player_type_1_\($0)" }).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.1)) }()
    
    override func didEnter(from previousState: GKState?) {
        player.removeAction(forKey: characterAnimationKey)
        player.run(action, withKey: characterAnimationKey)
    }
}

class IdleState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is LandingState.Type, is JumpingState.Type, is SlowingState.Type:
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

class SlowingState: PlayerState {
    
}
