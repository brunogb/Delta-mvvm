//
//  MovieListModel.swift
//  Delta
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

struct MovieListDisplayModel: TableViewDequeableModel {
    private static let dateFormmater: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter
    }()
    
    let dequeueClass: AnyClass = MovieListTableViewCell.self
    
    private static let basePosterURL = URL(staticString: "http://image.tmdb.org/t/p/w500/")
    private static let percentageAttributedString = NSAttributedString(string: "%", attributes: [.font: UIFont.preferredFont(forTextStyle: .footnote)])
    
    let id: Int
    let title: String
    let overview: String
    let dateFormatted: String
    let voteAverage: NSAttributedString
    let voteColor: UIColor
    let posterURL: URL
    
    init(from movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        self.dateFormatted = type(of: self).dateFormmater.string(from: movie.releaseDate)
        let average = Int(movie.voteAverage * 10)
        let averageAttributed = NSMutableAttributedString(string: "\(average)", attributes: [.font: UIFont.preferredFont(forTextStyle: .title2)])
        averageAttributed.append(type(of: self).percentageAttributedString)
        self.voteAverage = averageAttributed
        self.voteColor = .color(forAverage: average)
        self.posterURL = type(of: self).basePosterURL.appendingPathComponent(movie.posterId)
    }
    
}

private extension UIColor {
    
    static func color(forAverage average: Int)-> UIColor {
        switch average {
        case 70...:
            return UIColor(red: 85/255.0, green: 170/255.0, blue: 104/255.0, alpha: 1)
        case 40..<70:
            return UIColor(red: 217/255.0, green: 130/255.0, blue: 19/255.0, alpha: 1)
        case ..<40:
            return UIColor(red: 178/255.0, green: 67/255.0, blue: 52/255.0, alpha: 1)
        default:
            return .black
        }
    }
    
}
