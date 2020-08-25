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
        
        self.startGame()
    }
    
    func startGame() {
        let view: SKView = self.view as! SKView
        
        let scene = TitleScreenScene.newGameScene()
        scene.scaleMode = .aspectFill
        
        view.presentScene(scene)
        
        view.ignoresSiblingOrder = false
        
        view.showsFPS = true
        
        view.showsNodeCount = true
    }

}

