//
//  GameViewController.swift
//  Super Mario Swift macOS
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view: SKView = self.view as? SKView {
            if let scene = SKScene(fileNamed: "TitleScreenScene") {
                scene.scaleMode = .aspectFill
                
                (scene as! TitleScreenScene).startGame()
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = false
            
            view.showsFPS = true
            
            view.showsNodeCount = true
        }
    }

}

