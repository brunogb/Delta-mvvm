//
//  MovieDetailViewController.swift
//  Delta
//
//  Created by Bruno Bilescky on 15/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    private lazy var favoriteBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(customView: self.favoriteButton)
        return item
    }()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(containerView)
        containerView.addSubview(posterImageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        self.view.backgroundColor = .gray
        title = viewModel.movie.title
        navigationItem.rightBarButtonItem = favoriteBarButtonItem
        updateFavoriteButton()
        viewModel.fetchPosterImage().then { (image) in
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    private func updateFavoriteButton() {
        let imageName = viewModel.movieIsFavorite() ? "heart_icon" : "heart_unselected"
        favoriteButton.setImage(UIImage(named: imageName), for: .normal)
    }

    private func configureLayout() {
        containerView.alignInsideSuperview(insets: UIEdgeInsets(left: 8, right: 8), edges: [.left, .right])
        containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1.33)
        posterImageView.alignInsideSuperview(insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4), edges: .all)
        containerView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    @objc private func favoriteButtonTapped() {
        viewModel.toggleFavorite()
        updateFavoriteButton()
    }
    
}
