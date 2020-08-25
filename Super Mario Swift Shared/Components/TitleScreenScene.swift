//
//  TitleScreenScene.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/24.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class TitleScreenScene: SKScene {
    
    fileprivate var gameSwitchNode: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        self.gameSwitchNode = self.childNode(withName: "//gameSwitchNode") as? SKSpriteNode
    }
    
    override func keyDown(with event: NSEvent) {
        let key = event.characters!
        if key.elementsEqual(Constants.BUTTON_A) {
            guard let gameSwitchNode = gameSwitchNode else { return }
            let action = SKAction.moveTo(y: gameSwitchNode.position.y == -100 ? -140 : -100, duration: 0.1)
            gameSwitchNode.run(action)
        } else if key.elementsEqual(Constants.BUTTON_START) {
            print("Starting Game...")
//            self.view?.presentScene(TitleScreenSceneTest.loadingGame(), transition: .fade(withDuration: 0.5))
        }
    }
    
    class func newGameScene() -> TitleScreenScene {
        // Load 'TitleScrene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "TitleScrene") as? TitleScreenScene else {
            print("Failed to load TitleScrene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
}
