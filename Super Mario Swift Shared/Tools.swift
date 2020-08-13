//
//  Tools.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class Tools {
    
    open class func cropTexture(imageNamed: String, rect: CGRect?) -> SKTexture {
        let texture = SKTexture.init(imageNamed: imageNamed)
        guard rect != nil else {
            return texture
        }
        return SKTexture.init(rect: rect!, in: texture)
    }
    
//    open class func cropImage(imageNamed: String, rect: CGRect?) -> CGImage {
//        let image = NSImage.init(byReferencingFile: "")
//
//
//        return image
//    }
}
