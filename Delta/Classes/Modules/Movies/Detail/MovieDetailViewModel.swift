//
//  MovieDetailViewModel.swift
//  Delta
//
//  Created by Bruno Bilescky on 15/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

class MovieDetailViewModel {
    
    let movie: MovieListDisplayModel
    let imageService: ImageServiceProtocol
    let favoriteService: FavoriteService
    
    init(movie: MovieListDisplayModel, imageService: ImageServiceProtocol, favoriteService: FavoriteService) {
        self.movie = movie
        self.imageService = imageService
        self.favoriteService = favoriteService
    }
    
    func movieIsFavorite()-> Bool {
        return self.favoriteService.isMovieFavorite(movieId: movie.id)
    }
    
    func toggleFavorite() {
        if movieIsFavorite() {
            self.favoriteService.removeFavorite(movieId: movie.id)
        }
        else {
            self.favoriteService.addFavorite(movieId: movie.id)
        }
    }
    
    func fetchPosterImage()-> Promise<UIImage> {
        return imageService.fetchImage(from: movie.posterURL)
    }
    
}
