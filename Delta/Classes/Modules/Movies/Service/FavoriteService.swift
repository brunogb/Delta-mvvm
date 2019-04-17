//
//  FavoriteService.swift
//  Delta
//
//  Created by Bruno Bilescky on 15/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

class FavoriteService {

    private let favoriteIds = "storage.service.favorites"
    
    let storage: StorageService
    var moviesIds: Set<Int> = [] {
        didSet {
            storage.update(set: moviesIds, for: favoriteIds)
        }
    }
    
    init(storageService: StorageService) {
        self.storage = storageService
        self.moviesIds = storageService.set(for: favoriteIds)
    }
    
    func isMovieFavorite(movieId: Int)-> Bool {
        return moviesIds.contains(movieId)
    }
    
    func addFavorite(movieId: Int) {
        moviesIds.insert(movieId)
    }
    
    func removeFavorite(movieId: Int) {
        moviesIds.remove(movieId)
    }
    
}
