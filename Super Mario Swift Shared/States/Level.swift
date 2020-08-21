//
//  Level.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import Foundation

class Level {
    
    private var level: String
    
    init(level: String) {
        self.level = level
    }
    
    var currentLevel: String {
        get {
            return self.level
        }
    }
    
    var nextLevel: String {
        get {
            let splits = self.level.split(separator: "-")
            
            var chapter: Int = Int(splits[0])!
            
            var session: Int = Int(splits[1])!
            
            if session < 4 {
                session += 1
            } else if session == 4 {
                chapter += 1
                session = 1
            }
            
            return "\(chapter)-\(session)"
        }
    }
}
