//
//  Tools.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit
import SwiftyJSON

class Tools {
    
    class func openMapFile(_ level: String) -> JSON {
        let path = Bundle.main.path(forResource: level.replacingOccurrences(of: "-", with: "_"), ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            
            let jsonData = try JSON(data: data)
            
            return jsonData
        } catch let error as Error? {
            print("read local map data error!", error as Any)
            return JSON()
        }
    }
    
    class func drawGroundMap(_ ground: JSON, tileSize: CGSize) -> SKTileMapNode {
        guard let groundBrickTileSet = SKTileSet(named: "GroundBrickTileSet") else {
          fatalError("GroundBrickTileSet not found")
        }
        
        let groundBrickTileGroup = groundBrickTileSet.tileGroups
        
        let groundMap = SKTileMapNode(tileSet: groundBrickTileSet, columns: ground["columns"].intValue, rows: ground["rows"].intValue, tileSize: tileSize)
        groundMap.position = CGPoint(x: ground["x"].doubleValue, y: ground["y"].doubleValue)
        groundMap.anchorPoint = CGPoint(x: 0, y: 0)

        guard let centerBrickGroup = groundBrickTileGroup.first(where: {$0.name == "GroundBrickGroup"}) else {
            fatalError("No GroundBrickGroup found")
        }

        // compute ground bluff position
        var bluffColums: [Int] = [Int]()
        for bluff in ground["tiles"].arrayValue {
            let col = bluff["column"].intValue
            let step = bluff["repeat"].intValue
            
            for index in 1...step {
                let value = col + index - 1
                if !bluffColums.contains(value) {
                    bluffColums.append(value)
                }
            }
        }

        // draw ground tile sprites skip bluff brick
        for row in 0...ground["rows"].intValue - 1 {
            for col in 0...ground["columns"].intValue - 1 {
                if bluffColums.contains(col) {
                    continue
                }
                groundMap.setTileGroup(centerBrickGroup, forColumn: col, row: row)
            }
        }
        
        return groundMap
    }
    
    class func drawBrickMap(_ brick: JSON, tileSize: CGSize) -> SKTileMapNode {
        guard let brickTileSet = SKTileSet(named: "BrickTileSet") else {
          fatalError("BrickTileSet not found")
        }
        
        let brickTileGroup = brickTileSet.tileGroups
        
        let brickMap = SKTileMapNode(tileSet: brickTileSet, columns: brick["columns"].intValue, rows: brick["rows"].intValue, tileSize: tileSize)
        brickMap.position = CGPoint(x: brick["x"].doubleValue, y: brick["y"].doubleValue)
        brickMap.anchorPoint = CGPoint(x: 0, y: 0)

        guard let normalBrickGroup = brickTileGroup.first(where: {$0.name == "NormalBrickGroup"}) else {
            fatalError("No NormalBrickGroup found")
        }

        // draw brick tile sprites
        // TODO 处理不同类型的brick
        for item in brick["tiles"].arrayValue {
            brickMap.setTileGroup(normalBrickGroup, forColumn: item["column"].intValue, row: item["row"].intValue)
        }
        
        return brickMap
    }
}
