//
//  Level11Scene.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/18.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class Level_1_1Scene: SKScene {

    class func gameScene() -> Level_1_1Scene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "Level_1_1") as? Level_1_1Scene else {
            print("Failed to load Level_1_1Scene.sks")
            abort()
        }
        
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
}
