//
//  Info.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/11.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import Foundation

class Info {
    
    public static var gameLevel: String {
        get{
            let v = UserDefaults.standard.value(forKey: "gameLevel")
            return v == nil ? "1-1" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "gameLevel")
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var points: String {
        get{
            let v = UserDefaults.standard.value(forKey: "points")
            return v == nil ? "000000" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "points")
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var record: String {
        get{
            let v = UserDefaults.standard.value(forKey: "record")
            return v == nil ? "000000" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "record")
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var coins: String {
        get{
            let v = UserDefaults.standard.value(forKey: "coins")
            return v == nil ? "00" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "coins")
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var life: Int {
        get{
            let v = UserDefaults.standard.value(forKey: "life")
            return v == nil ? 3 : v as! Int
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "life")
            UserDefaults.standard.synchronize()
        }
    }
}
