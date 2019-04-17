//
//  MovieListViewModel.swift
//  Delta
//
//  Created by Bruno Bilescky on 14/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

struct MoviePage {
    var items: [MovieListDisplayModel]
    var numberOfMovies: Int { return items.count }
}

class MovieListViewModel {

    enum State {
        case idle
        case loading
    }
    
    var state: State = .idle
    
    let networkService: NetworkServiceProtocol
    let imageService: ImageServiceProtocol
    let favoriteService: FavoriteService
    let loadMoreThreshold: Int
    
    var onMovieSelected: (MovieListDisplayModel)-> Void = { _ in }
    
    private var moviePages: [MoviePage] = []
    
    init(networkService: NetworkServiceProtocol, imageService: ImageServiceProtocol, favoriteService: FavoriteService, loadMoreThreshold: Int) {
        self.networkService = networkService
        self.favoriteService = favoriteService
        self.imageService = imageService
        self.loadMoreThreshold = loadMoreThreshold
    }
    
    private func makeRequestForNextPage() -> Promise<[MoviePage]> {
        let nextPage = self.moviePages.count + 1
        let promise = self.networkService.request(request: PopularMoviesRequest(page: nextPage)).then { (response) -> [MoviePage] in
            let movies = response.results.map(MovieListDisplayModel.init(from:))
            let page = MoviePage(items: movies)
            self.moviePages.append(page)
            return self.moviePages
        }
        return promise
    }
    
    func loadMoreItemsIfThresholdReached(at indexPath: IndexPath)-> Promise<[MoviePage]>? {
        guard indexPath.section == self.numberOfPages() - 1,
            indexPath.row >= self.loadMoreThreshold else { return nil }
        return loadDataForNextPage()
    }
    
    func numberOfPages()-> Int {
        return self.moviePages.count
    }
    
    func page(at index: Int)-> MoviePage {
        return self.moviePages[index]
    }
    
    func movie(at indexPath: IndexPath)-> MovieListDisplayModel {
        return page(at: indexPath.section).items[indexPath.row]
    }
    
    func movieIsFavorite(_ movie: MovieListDisplayModel)-> Bool {
        return self.favoriteService.isMovieFavorite(movieId: movie.id)
    }
    
    func toggleFavorite(for movie: MovieListDisplayModel) {
        if movieIsFavorite(movie) {
            self.favoriteService.removeFavorite(movieId: movie.id)
        }
        else {
            self.favoriteService.addFavorite(movieId: movie.id)
        }
    }
    
    func didSelect(indexPath: IndexPath) {
        let selected = movie(at: indexPath)
        self.onMovieSelected(selected)
    }
    
    func loadDataForNextPage()-> Promise<[MoviePage]>? {
        switch self.state {
        case .idle:
            self.state = .loading
            let promise = self.makeRequestForNextPage()
            promise.finally {
                self.state = .idle
            }
            return promise
        case .loading:
            return nil
        }
    }
    
    func poster(for movie: MovieListDisplayModel)-> Promise<UIImage> {
        return self.imageService.fetchImage(from: movie.posterURL)
    }
    
}
