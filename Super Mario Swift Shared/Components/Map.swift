//
//  Map.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/29.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit
import GameplayKit
import SwiftyJSON

class Map: SKScene {
    
    fileprivate var mapJson: JSON = JSON()
    
    fileprivate var cameraNode: SKCameraNode = SKCameraNode.init()
    fileprivate var player: SKSpriteNode!
    
    fileprivate var previousTimeInterval: TimeInterval = 0
    fileprivate var playerIsFacingRight = true
    
    fileprivate var playerStateMachine: GKStateMachine!
    
    var xVelocity: Double = 0
    var yVelocity: Double = 0
    
    init(level: String, size: CGSize) {
        super.init(size: size)
        
        mapJson = Tools.openMapFile(level)
        
        // TODO record the level
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN)
        self.backgroundColor = Constants.BACKGROUND_COLOR
        self.scaleMode = .aspectFill
        
        // camera
        cameraNode.position = CGPoint(x: Constants.W_SCREEN / 2, y: Constants.H_SCREEN / 2)
        self.camera = cameraNode
        
        // player
        player = Player.buildPlayer()
        self.addChild(player)
        
        playerStateMachine = GKStateMachine(states: [
            JumpingState(player: player),
            LandingState(player: player),
            WalkingState(player: player),
            IdleState(player: player),
            SlowingState(player: player)
        ])
        
        playerStateMachine.enter(IdleState.self)
        
        
        let map: JSON = mapJson["map"]
        let tileWidth = map["size"].arrayValue[0].doubleValue
        let tileHeight = map["size"].arrayValue[1].doubleValue
        
        let tileSize = CGSize(width: tileWidth, height: tileHeight)
        
        
        let ground: JSON = mapJson["ground"]
        
        // ground
        let groundMap = Tools.drawGroundMap(ground, tileSize: tileSize)
        self.addChild(groundMap)
        
        
        let brick: JSON = mapJson["bricks"]
        
        // brick
        let brickMap = Tools.drawBrickMap(brick, tileSize: tileSize)
        self.addChild(brickMap)
        
        
//        let clouds: JSON = mapJson["clouds"]
//        let grass: JSON = mapJson["grass"]
//        let tubes: JSON = mapJson["tubes"]
//        let enemies: JSON = mapJson["enemies"]
    }
    
    func makeSpinny(at pos: CGPoint) {
        print(pos)
        let testNode = Player.buildPlayer()
        testNode.position = pos
        self.addChild(testNode)
    }
    
    class func nextScene() -> SKScene {
        return Map.init(level: "level_\(Level(level: Info.gameLevel).nextLevel)", size: CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN))
    }
}

// MARK Game Action
extension Map {

    override func keyDown(with event: NSEvent) {
        
//        if !playerAction { return }
        
        guard let player = player else { return }
        let key = event.characters!.lowercased()
        switch key {
        case Constants.BUTTON_LEFT:
            xVelocity = -5
            playerStateMachine.enter(WalkingState.self)
            break
        case Constants.BUTTON_RIGHT:
            xVelocity = 5
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
    
    override func keyUp(with event: NSEvent) {
        guard let player = player else { return }
        let key = event.characters!.lowercased()
        
        if playerStateMachine.currentState! is WalkingState {
            switch key {
            case Constants.BUTTON_LEFT:
                xVelocity = 0
                playerStateMachine.enter(SlowingState.self)
                break
            case Constants.BUTTON_RIGHT:
                xVelocity = 0
                playerStateMachine.enter(SlowingState.self)
                break
            case Constants.BUTTON_DOWN:
                // 下蹲，纹理变换Action
                break
            case Constants.BUTTON_A:
                break
            default:
                break
            }
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        makeSpinny(at: event.location(in: self))
    }
}

// MARK Game loop
extension Map {
    
    override func update(_ currentTime: TimeInterval) {
        guard let player = player else { return }
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
        
        // TODO 整理几种状态的切换条件
        if xVelocity == 0 {
            playerStateMachine.enter(IdleState.self)
        } else {
            playerStateMachine.enter(WalkingState.self)
        }
        
        let displacement = CGVector(dx: deltaTime * xVelocity * 50, dy: 0)
        let move = SKAction.move(by: displacement, duration: 0)
        
        let faceAction: SKAction!
        let faceRight = xVelocity > 0
        let faceLeft = xVelocity < 0
        if faceLeft && playerIsFacingRight {
            playerIsFacingRight = false
            let faceMovement = SKAction.scaleX(to: -1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        }
        else if faceRight && !playerIsFacingRight {
            playerIsFacingRight = true
            let faceMovement = SKAction.scaleX(to: 1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        }
        else {
            faceAction = move
        }
        player.run(faceAction)
    }
}
