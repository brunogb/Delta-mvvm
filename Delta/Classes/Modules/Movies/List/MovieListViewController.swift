//
//  MovieListViewController.swift
//  Delta
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    private lazy var tableView: UITableView = self.createTableView()
    
    let viewModel: MovieListViewModel
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        tableView.alignInsideSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular Movies"
        let promise = self.viewModel.loadDataForNextPage()
        updateDataSource(from: promise)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows ?? [], with: .automatic)
    }
    
    private func updateDataSource(from promise: Promise<[MoviePage]>?) {
        guard let promise = promise else { return }
        promise.then({ pages in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).onError({ self.presentAlert(from: $0) })
    }
    
    private func presentAlert(from error: Error) {
        let alert = UIAlertController(title: "error", message: "\(error)", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createTableView()-> UITableView {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        return view
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfPages()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.page(at: section).numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.viewModel.movie(at: indexPath)
        let cell = tableView.registerAndDequeue(cellFor: movie, at: indexPath)
        return cell
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    private func loadMoreItemsIfThresholdHit(at indexPath: IndexPath) {
        if let promise = self.viewModel.loadMoreItemsIfThresholdReached(at: indexPath) {
            self.updateDataSource(from: promise)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.loadMoreItemsIfThresholdHit(at: indexPath)
        guard let cell = cell as? MovieListTableViewCell else { return }
        let movie = self.viewModel.movie(at: indexPath)
        cell.display(movie: movie, favorite: viewModel.movieIsFavorite(movie))
        cell.onFavoriteButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.toggleFavorite(for: movie)
            cell.display(movie: movie, favorite: self.viewModel.movieIsFavorite(movie))
        }
        self.viewModel.poster(for: movie).then({ (image) in
            DispatchQueue.main.async {
                cell.updatePoster(image, for: movie)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelect(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
