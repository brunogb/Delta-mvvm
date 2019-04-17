//
//  PopularMoviesRequest.swift
//  Delta
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

struct PopularMoviesResponse: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    init(from decoder: Decoder) throws {
        page = try decoder.decode("page")
        totalResults = try decoder.decode("total_results")
        totalPages = try decoder.decode("total_pages")
        results = try decoder.decode("results")
    }
}

class PopularMoviesRequest: TheMovieDBNetworkRequest<PopularMoviesResponse> {
    
    override var urlComponents: URLComponents {
        var components = super.urlComponents
        components.path = "/3/movie/popular"
        components.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        return components
    }

    let page: Int
    
    init(page: Int) {
        self.page = page
    }
    
}
