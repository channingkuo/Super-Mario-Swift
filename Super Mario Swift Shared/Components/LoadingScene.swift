//
//  LoadingScene.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class LoadingScene: SKScene {
    
    fileprivate var topTitleNode: SKNode?
    fileprivate var gamePointNode: SKLabelNode?
    fileprivate var gameCoinNode: SKLabelNode?
    fileprivate var gameLevelNode: SKLabelNode?
    fileprivate var gameTimeNode: SKLabelNode?
    fileprivate var gameLevelCenterNode: SKLabelNode?
    fileprivate var gameLifeNode: SKLabelNode?
    
    override func didMove(to view: SKView) {
        topTitleNode = self.childNode(withName: "//topTitleNode")
        
        gamePointNode = topTitleNode!.childNode(withName: "//gamePointNode") as? SKLabelNode
        gamePointNode!.text = Info.points
        
        gameCoinNode = topTitleNode!.childNode(withName: "//gameCoinNode") as? SKLabelNode
        gameCoinNode!.text = "x \(Info.coins)"
        
        gameLevelNode = topTitleNode!.childNode(withName: "//gameLevelNode") as? SKLabelNode
        gameLevelNode!.text = Level(level: Info.gameLevel).currentLevel
        
        gameTimeNode = topTitleNode!.childNode(withName: "//gameTimeNode") as? SKLabelNode
        gameTimeNode!.text = ""
        
        gameLevelCenterNode = self.childNode(withName: "//gameLevelCenterNode") as? SKLabelNode
        gameLevelCenterNode!.text = Level(level: Info.gameLevel).currentLevel
        
        gameLifeNode = self.childNode(withName: "//gameLifeNode") as? SKLabelNode
        gameLifeNode!.text = String(Info.life)
        
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(presentGame), userInfo: nil, repeats: false)
    }
    
    @objc func presentGame() {
        self.view?.presentScene(Level_1_1Scene.gameScene(), transition: .fade(withDuration: 0.3))
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
