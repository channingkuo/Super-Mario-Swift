//
//  Map.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/29.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit
import SwiftyJSON

class Map: SKScene {
    
    fileprivate var mapJson: JSON = JSON()
    
    fileprivate var cameraNode: SKCameraNode = SKCameraNode.init()
    fileprivate var player: Player!
    
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
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    class func nextScene() -> SKScene {
        return Map.init(level: "level_\(Level(level: Info.gameLevel).nextLevel)", size: CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN))
    }
}

extension Map {

    override func keyDown(with event: NSEvent) {
        let key = event.characters!.lowercased()
        switch key {
        case Constants.BUTTON_LEFT:
            self.player.position.x -= 100
            break
        case Constants.BUTTON_DOWN:
            break
        case Constants.BUTTON_RIGHT:
            self.player.position.x += 100
            break
        case Constants.BUTTON_UP:
            break
        default:
            break
        }
    }
}

