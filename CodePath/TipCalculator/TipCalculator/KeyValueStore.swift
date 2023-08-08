//
//  KeyValueStore.swift
//  TipCalculator
//
//  Created by Di Wang on 8/20/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import Foundation

class KeyValueStore {
    static let keyTipPercentage = "tip_percentage_key";
    
    static func storeInt(_ value:Int, forKey key:String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey:key);
        defaults.synchronize()
    }
    
    static func getInt(forKey key:String, withDefault defaultValue:Int) -> Int {
        let defaults = UserDefaults.standard
        let result = defaults.integer(forKey: key)
        if result == 0 {
            return defaultValue
        }
        return result;
    }
}
