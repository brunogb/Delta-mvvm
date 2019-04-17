//
//  MovieListTableViewCell.swift
//  Delta
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(white: 0.15, alpha: 1)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.numberOfLines = 2
        return label
    }()
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(white: 0.35, alpha: 1)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(white: 0.35, alpha: 1)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.numberOfLines = 0
        return label
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var onFavoriteButtonTapped: ()-> Void = { }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.contentView.addSubview(containerView)
        self.contentView.backgroundColor = .lightGray
        containerView.addSubview(posterImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(releaseDateLabel)
        containerView.addSubview(favoriteButton)
        containerView.addSubview(overviewLabel)
        containerView.addSubview(ratingLabel)
        configureLayout()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    private func configureLayout() {
        let space: CGFloat = 6
        containerView.alignInsideSuperview(insets: UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4), edges: .all)
        posterImageView.alignInsideSuperview(edges: [.top, .left, .bottom])
        ratingLabel.alignInsideSuperview(insets: UIEdgeInsets(right: space, bottom: space), edges: [.right, .bottom])
        favoriteButton.alignInsideSuperview(insets: UIEdgeInsets(top: space, right: space), edges: [.top, .right])
        titleLabel.alignInsideSuperview(insets: UIEdgeInsets(top: space * 2), edges: [.top])
        overviewLabel.alignInsideSuperview(insets: UIEdgeInsets(right: space), edges: .right)
        NSLayoutConstraint.activate([
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: space),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -space),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: space),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: ratingLabel.topAnchor, constant: -space),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.66),
            posterImageView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        display(movie: nil, favorite: false)
        self.posterImageView.image = nil
    }
    
    func display(movie: MovieListDisplayModel?, favorite: Bool) {
        titleLabel.text = movie?.title
        releaseDateLabel.text = movie?.dateFormatted
        overviewLabel.text = movie?.overview
        ratingLabel.attributedText = movie?.voteAverage
        ratingLabel.textColor = movie?.voteColor
        tag = movie?.id ?? 0
        if favorite {
            favoriteButton.setImage(UIImage(named: "heart_icon"), for: .normal)
        }
        else {
            favoriteButton.setImage(UIImage(named: "heart_unselected"), for: .normal)
        }
        self.setNeedsDisplay()
    }
    
    func updatePoster(_ image: UIImage, for movie: MovieListDisplayModel) {
        if tag == movie.id {
            self.posterImageView.image = image
        }
    }
    
    @objc private func favoriteButtonTapped() {
        onFavoriteButtonTapped()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
