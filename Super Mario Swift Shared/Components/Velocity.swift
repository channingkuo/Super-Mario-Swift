//
//  Velocity.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/9/4.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import Foundation

struct Velocity {
    
    private var xVelocity: Double = 0
    private var yVelocity: Double = 0
    
    init() {
        self.xVelocity = 0
        self.yVelocity = 0
    }
    
    init(xVelocity: Double) {
        self.xVelocity = xVelocity
        self.yVelocity = 0
    }
    
    init(xVelocity: Double, yVelocity: Double) {
        self.xVelocity = xVelocity
        self.yVelocity = yVelocity
    }
    
    mutating func append(velocity: Velocity) {
        self.xVelocity += velocity.xVelocity
        self.yVelocity += velocity.yVelocity
    }
    
    var y: Double {
        get {
            return self.yVelocity
        }
        set {
            self.yVelocity = newValue
        }
    }
    
    var x: Double {
        get {
            return self.xVelocity
        }
        set {
            self.xVelocity = newValue
        }
    }
}
