//
//  NetworkRequest.swift
//  Delta
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

protocol NetworkRequest {
    associatedtype Response: Decodable
    var urlComponents: URLComponents { get }
    
}
