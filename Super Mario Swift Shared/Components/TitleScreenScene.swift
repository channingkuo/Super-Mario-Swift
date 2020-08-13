//
//  TitleScreen.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/13.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class TitleScreenScene: SKScene {
    
    var backgroundNode: SKNode?
    
    var topNode: SKNode?
    var pointsNode: SKNode?
    var coinsNode: SKNode?
    var levelNode: SKNode?
    var timeNode: SKNode?
    
    var centerNode: SKNode?
    var logoNode: SKNode?
    var levelSwitchNode: SKNode?
    
    override func didMove(to view: SKView) {
        
        backgroundNode = childNode(withName: "backgroundNode")
        
        topNode = childNode(withName: "topNode")
        pointsNode = topNode!.childNode(withName: "pointsNode")
        coinsNode = topNode!.childNode(withName: "coinsNode")
        levelNode = topNode!.childNode(withName: "levelNode")
        timeNode = topNode!.childNode(withName: "timeNode")
        
        centerNode = childNode(withName: "centerNode")
        logoNode = centerNode!.childNode(withName: "logoNode")
        levelSwitchNode = centerNode!.childNode(withName: "levelSwitchNode")
    }
    
    override func update(_ currentTime: TimeInterval) {
        <#code#>
    }
    
    func startGame() {
        let skSpriteNode: SKSpriteNode = SKSpriteNode()
        skSpriteNode.size = CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN)
        skSpriteNode.position = CGPoint(x: 0, y: 0)
        skSpriteNode.anchorPoint = CGPoint(x: 0, y: 0)
        skSpriteNode.texture = Tools.cropTexture(imageNamed: "level_1_1", rect: CGRect(x: 0, y: 0, width: 0.080895513332592, height: 1))
        
//        (backgroundNode as? SKSpriteNode)?.color = .red
//        (backgroundNode as? SKSpriteNode)?.texture = Tools.cropTexture(imageNamed: "level_1_1", rect: CGRect(x: 0, y: 0, width: 0.080895513332592, height: 1))
        backgroundNode?.addChild(skSpriteNode)
    }
    
    class func startGameTest() -> TitleScreenScene {
            // Load 'TitleScreen.sks' as an SKScene.
            guard let scene = SKScene(fileNamed: "TitleScreenScene") as? TitleScreenScene else {
                print("Failed to load Title Screen Scene")
                abort()
            }
            
            // Set the scale mode to scale to fit the window
    //        scene.scaleMode = .aspectFill
            
            return scene
        }
}
