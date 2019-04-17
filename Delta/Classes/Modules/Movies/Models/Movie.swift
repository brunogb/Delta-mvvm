//
//  Movie.swift
//  Delta
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

struct Movie: Decodable {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let id: Int
    let title: String
    let releaseDate: Date
    let overview: String
    let voteAverage: Float
    let posterId: String
    
    init(from decoder: Decoder) throws {
        id = try decoder.decode("id")
        title = try decoder.decode("title")
        overview = try decoder.decode("overview")
        voteAverage = try decoder.decode("vote_average")
        releaseDate = try decoder.decode("release_date", using: Movie.dateFormatter)
        posterId = try decoder.decode("poster_path")
    }
    
}
