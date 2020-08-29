//
//  Map.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/29.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class Map: SKScene {
    
    fileprivate var mapDictionary: NSDictionary = NSDictionary()
    
    init(level: String, size: CGSize) {
        super.init(size: size)
        
        self.mapDictionary = Tools.openJsonFile(level)
        
        // TODO record the level
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let map = elementValue(element: self.mapDictionary, forKey: "map", type: NSDictionary.self)
        let identity = elementValue(element: map, forKey: "identity", type: NSDictionary.self)

        let col = elementValue(element: map, forKey: "col", type: CGFloat.self)
        let row = elementValue(element: map, forKey: "row", type: CGFloat.self)
        let height = elementValue(element: map, forKey: "height", type: CGFloat.self)
        let baseWidth = elementValue(element: identity, forKey: "width", type: CGFloat.self)
        let baseHeight = elementValue(element: identity, forKey: "height", type: CGFloat.self)

        self.size = CGSize(width: col * baseWidth, height: height)

        let ground = elementValue(element: self.mapDictionary, forKey: "ground", type: NSArray.self)

        let brickTileSet = SKTileSet(named: "BrickTileSet")!
        let tileMap = SKTileMapNode(tileSet: brickTileSet, columns: Int(col), rows: Int(ceil(row)), tileSize: CGSize(width: baseWidth, height: baseHeight), tileGroupLayout: brickTileSet.tileGroups)
        tileMap.anchorPoint = CGPoint(x: 0, y: 0)
        tileMap.position = CGPoint(x: 300, y: 0)
        self.addChild(tileMap)
    }
    
    func elementValue<T>(element: NSDictionary, forKey key: String, type: T.Type) -> T {
        return element.value(forKey: key) as! T
    }
    
    class func nextScene() -> SKScene {
        return Map.init(level: "level_\(Level(level: Info.gameLevel).nextLevel)", size: CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN))
    }
}
