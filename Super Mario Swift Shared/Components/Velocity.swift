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
    private var xAcceleration: Double = 0
    private var yAcceleration: Double = 0
    
    init() {
        self.xVelocity = 0
        self.yVelocity = 0
        self.xAcceleration = 0
        self.yAcceleration = 0
    }
    
    init(xVelocity: Double) {
        self.xVelocity = xVelocity
        self.yVelocity = 0
        self.xAcceleration = 0
        self.yAcceleration = 0
    }
    
    init(xVelocity: Double, yVelocity: Double) {
        self.xVelocity = xVelocity
        self.yVelocity = yVelocity
        self.xAcceleration = 0
        self.yAcceleration = 0
    }

    init(xVelocity: Double, xAcceleration: Double) {
        self.xVelocity = xVelocity
        self.yVelocity = 0
        self.xAcceleration = xAcceleration
        self.yAcceleration = 0
    }

    init(yVelocity: Double, yAcceleration: Double) {
        self.xVelocity = 0
        self.yVelocity = yVelocity
        self.xAcceleration = 0
        self.yAcceleration = yAcceleration
    }
    
    mutating func append(velocity: Velocity) {
        self.xVelocity += velocity.xVelocity
        self.yVelocity += velocity.yVelocity
    }
    
    var v_y: Double {
        get {
            return self.yVelocity
        }
        set {
            self.yVelocity = newValue
        }
    }
    
    var v_x: Double {
        get {
            return self.xVelocity
        }
        set {
            self.xVelocity = newValue
        }
    }

    var a_x: Double {
      get {
            return self.xAcceleration
        }
        set {
            self.xAcceleration = newValue
        }
    }

    var a_y: Double {
      get {
            return self.yAcceleration
        }
        set {
            self.yAcceleration = newValue
        }
    }
}
