//
//  LoadingScene.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class LoadingScene: SKScene {
    
    override func didMove(to view: SKView) {
        
    }
    
    override func keyDown(with event: NSEvent) {
        // remove key down's sound
    }
    
    class func newLoadingScene() -> LoadingScene {
        // Load 'LoadingScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "LoadingScene") as? LoadingScene else {
            print("Failed to load LoadingScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
}
