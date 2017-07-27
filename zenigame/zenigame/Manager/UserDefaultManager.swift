//
//  UserDefaultManager.swift
//  MyLifeMatters
//
//  Created by Thanh-Tam Le on 11/29/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import UIKit

class UserDefaultManager {

    private static var sharedInstance: UserDefaultManager!
    
    private let defaults = UserDefaults.standard
    
    private let isSignIn = "isSignIn"

    static func getInstance() -> UserDefaultManager {
        if(sharedInstance == nil) {
            sharedInstance = UserDefaultManager()
        }
        return sharedInstance
    }
    
    private init() {
        
    }

    func setIsSignIn(value: Bool) {
        defaults.set(value, forKey: isSignIn)
        defaults.synchronize()
    }
    
    func getIsSignIn() -> Bool {
        return defaults.bool(forKey: isSignIn)
    }
}

