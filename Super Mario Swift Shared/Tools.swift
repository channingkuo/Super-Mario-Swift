//
//  Tools.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class Tools {
    
    // level_1_1
    private static let mapWidth: CGFloat = 3692
    private static let mapHeight: CGFloat = 224
    
    class func genNewGameBackGroundTexture() -> SKTexture {
        let scaleRate = Constants.W_SCREEN / (Constants.H_SCREEN / Tools.mapHeight * Tools.mapWidth)
        
        let newGameRect: CGRect = CGRect(x: 0, y: 0, width: scaleRate, height: 1)
        
        return self.cropTexture(imageNamed: "Maps/level_1_1", rect: newGameRect)
    }
    
    class func genSKLabelNode(text: String, position: CGPoint, size: CGFloat?) -> SKLabelNode {
        let node = SKLabelNode(fontNamed: Constants.FONT)
        node.text = text
        node.position = position
        guard let size = size else {
            node.fontSize = 30.0
            return node
        }
        node.fontSize = size
        return node
    }
    
    class func cropTexture(imageNamed: String, rect: CGRect?) -> SKTexture {
        let texture = SKTexture.init(imageNamed: imageNamed)
        guard rect != nil else {
            return texture
        }
        return SKTexture.init(rect: rect!, in: texture)
    }
}
