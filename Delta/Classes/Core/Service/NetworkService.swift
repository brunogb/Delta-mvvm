//
//  NetworkService.swift
//  Delta
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

struct NetworkError: Error {
    
    static let empty = NetworkError()
    
}

protocol NetworkServiceProtocol {
    func request<T: NetworkRequest>(request: T)-> Promise<T.Response>
}

class NetworkService: NetworkServiceProtocol {

    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func requestRawData(for url: URL)-> Promise<Data> {
        return Promise { resolve, reject in
            let task = self.session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard error == nil else {
                    return reject(error!)
                }
                guard let data = data, !data.isEmpty else {
                    return reject(NetworkError.empty)
                }
                resolve(data)
            })
            task.resume()
        }
    }
    
    func request<T: NetworkRequest>(request: T)-> Promise<T.Response> {
        guard let requestURL = request.urlComponents.url else {
            return Promise { resolve, reject in
                reject(NetworkError.empty)
            }
        }
        return requestRawData(for: requestURL).then({ (data) -> Promise<T.Response> in
            return self.parse(data: data, for: request)
        })
    }
    
    private func parse<T: NetworkRequest>(data: Data, for request: T)-> Promise<T.Response> {
        return Promise { resolve, reject in
            do {
                let result = try data.decoded() as T.Response
                resolve(result)
            }
            catch {
                reject(error)
            }
        }
    }
    
}
