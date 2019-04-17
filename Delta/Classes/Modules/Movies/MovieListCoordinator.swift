//
//  MovieListCoordinator.swift
//  Delta
//
//  Created by Bruno Bilescky on 15/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

class MovieListCoordinator {

    let networkService: NetworkServiceProtocol
    let imageService: ImageServiceProtocol
    let favoriteService: FavoriteService
    
    private lazy var listViewModel: MovieListViewModel = {
        let viewModel = MovieListViewModel(networkService: self.networkService,
                                           imageService: self.imageService,
                                           favoriteService: self.favoriteService,
                                           loadMoreThreshold: 15)
        viewModel.onMovieSelected = { [unowned self] movie in
            self.displayDetails(of: movie)
        }
        return viewModel
    }()
    
    private lazy var listViewController: MovieListViewController = {
        let viewController = MovieListViewController(viewModel: self.listViewModel)
        return viewController
    }()
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: self.listViewController)
        navigationController.navigationBar.barStyle = .blackTranslucent
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        return navigationController
    }()
    
    init(networkService: NetworkServiceProtocol, imageService: ImageServiceProtocol, favoriteService: FavoriteService) {
        self.networkService = networkService
        self.imageService = imageService
        self.favoriteService = favoriteService
    }
    
    func entryPoint()-> UIViewController {
        return self.navigationController
    }
    
    func displayDetails(of movie: MovieListDisplayModel) {
        let viewModel = MovieDetailViewModel(movie: movie,
                                             imageService: imageService,
                                             favoriteService: favoriteService)
        let viewController = MovieDetailViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
