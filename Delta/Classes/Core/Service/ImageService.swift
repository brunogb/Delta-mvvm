//
//  ImageService.swift
//  Delta
//
//  Created by Bruno Bilescky on 14/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

protocol ImageServiceProtocol {
    func fetchImage(from url: URL)-> Promise<UIImage>
}

class ImageService: ImageServiceProtocol {

    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchImage(from url: URL)-> Promise<UIImage> {
        return Promise { resolve, reject in
            let task = self.session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    return reject(error)
                }
                guard let data = data, let image = UIImage(data: data) else {
                    return reject(NetworkError.empty)
                }
                resolve(image)
            })
            task.resume()
        }
    }
    
}
