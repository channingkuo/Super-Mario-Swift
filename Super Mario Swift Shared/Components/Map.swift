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
        let baseWidth = elementValue(element: identity, forKey: "width", type: CGFloat.self)
        let baseHeight = elementValue(element: identity, forKey: "height", type: CGFloat.self)

        self.size = CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN)
        self.scaleMode = .aspectFill
        

        guard let groundBrickTileSet = SKTileSet(named: "GroundBrickTileSet") else {
          fatalError("GroundBrickTileSet Tile Set not found")
        }
        
        let columns = Int(ceil(col))
        let rows = Int(ceil(row))
        
        let tileMap = SKTileMapNode(tileSet: groundBrickTileSet, columns: columns, rows: rows, tileSize: CGSize(width: baseWidth, height: baseHeight))
        tileMap.position = CGPoint(x: 0, y: 0)
        tileMap.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(tileMap)
        
        let groundBrickTileGroup = groundBrickTileSet.tileGroups
        
        guard let groundBrickTile = groundBrickTileGroup.first(where: {$0.name == "CenterBrick"}) else {
            fatalError("No GroundBrick Group found")
        }
        
        guard let groundUpperEdgeBrickTile = groundBrickTileGroup.first(where: {$0.name == "UpperEdgeBrick"}) else {
            fatalError("No UpperEdgeBrick Group found")
        }
        
        let ground = elementValue(element: self.mapDictionary, forKey: "ground", type: NSArray.self)
        // 计算ground镂空部分
        var fullColums: [Int] = [Int]()
        for item in ground {
            let itemDic = item as! NSDictionary
            let colValue = elementValue(element: itemDic, forKey: "col", type: Int.self)
            let stepValue = elementValue(element: itemDic, forKey: "step", type: Int.self)
            for index in 1...stepValue {
                fullColums.append(colValue + index - 1)
            }
        }
        
        // 动态绘制地板瓦片精灵
        for row in 0...1 {
            if row == 0 {
                tileMap.tileSize = CGSize(width: 55, height: 39)
            }
            for col in 0...columns {
                if fullColums.contains(col) {
                    continue
                }
                tileMap.setTileGroup(row == 0 ? groundUpperEdgeBrickTile : groundBrickTile, forColumn: col, row: row)
            }
        }
    }
    
    func elementValue<T>(element: NSDictionary, forKey key: String, type: T.Type) -> T {
        return element.value(forKey: key) as! T
    }
    
    class func nextScene() -> SKScene {
        return Map.init(level: "level_\(Level(level: Info.gameLevel).nextLevel)", size: CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN))
    }
}
