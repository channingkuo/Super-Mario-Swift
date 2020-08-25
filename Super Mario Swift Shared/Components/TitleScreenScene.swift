//
//  TitleScreenScene.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/24.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class TitleScreenScene: SKScene {
    
    class func newGameScene() -> TitleScreenScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "TitleScrene") as? TitleScreenScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
}
