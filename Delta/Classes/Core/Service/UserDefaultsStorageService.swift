//
//  UserDefaultsStorageService.swift
//  Delta
//
//  Created by Bruno Bilescky on 15/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

class UserDefaultsStorageService: StorageService {

    private let userDefaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.userDefaults = defaults
    }
    
    func set<T>(for key: String)-> Set<T> {
        guard let value = userDefaults.array(forKey: key) as? [T] else {
            return Set()
        }
        return Set(value)
    }
    
    func update<T>(set: Set<T>, for key: String) {
        userDefaults.setValue(Array(set), forKey: key)
        userDefaults.synchronize()
    }
    
}
