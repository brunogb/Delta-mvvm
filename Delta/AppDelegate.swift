//
//  AppDelegate.swift
//  Delta
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var networkService: NetworkService = {
        let service = NetworkService()
        return service
    }()
    
    lazy var imageService: ImageService = {
        let service = ImageService()
        return service
    }()
    
    lazy var favoriteService: FavoriteService = {
        let storageService = UserDefaultsStorageService()
        return FavoriteService(storageService: storageService)
    }()
    
    lazy var rootCoordinator: MovieListCoordinator = {
        let coordinator = MovieListCoordinator(networkService: self.networkService, imageService: self.imageService, favoriteService: self.favoriteService)
        return coordinator
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        URLSessionConfiguration.default.requestCachePolicy = .returnCacheDataElseLoad
        window = UIWindow()
        window?.rootViewController = rootCoordinator.entryPoint()
        window?.makeKeyAndVisible()
        return true
    }

}

