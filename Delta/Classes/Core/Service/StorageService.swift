//
//  StorageService.swift
//  Delta
//
//  Created by Bruno Bilescky on 15/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

protocol StorageService {

    func set<T>(for key: String)-> Set<T>
    func update<T>(set: Set<T>, for key: String)
    
}
