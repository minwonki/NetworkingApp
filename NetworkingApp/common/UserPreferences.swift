//
//  UserPreferences.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation

class UserPreferences {
    //static let shared = UserPreferences()
    
    struct Key {
        static let token = "token"
    }
    
    //init() {}
    
    func setValue(value: Any?, forKey: String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
    }
    
    func getStringValue(forKey: String) -> String? {
        return UserDefaults.standard.string(forKey: forKey)
    }
    
    func getBoolValue(forKey: String) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }
    
    func getArrayValue(forKey: String) -> [Any]? {
        return UserDefaults.standard.array(forKey: forKey)
    }
}
