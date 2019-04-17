//
//  TheMovieDBNetworkRequest.swift
//  Delta
//
//  Created by Bruno Bilescky on 14/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

class TheMovieDBNetworkRequest<T:Decodable>: NetworkRequest {
    typealias Response = T
    
    private let apiKey = APIKey(value: "602b290a9029607efa2fea841c26c4ee")
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey.value)]
        return components
    }

}
