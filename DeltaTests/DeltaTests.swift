//
//  DeltaTests.swift
//  DeltaTests
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import XCTest
@testable import Delta

class DeltaTests: XCTestCase {

    class MockNetworkService: NetworkServiceProtocol {
        var onRequestedComponents: (URLComponents)-> Void = { _ in }
        func request<T>(request: T) -> Promise<T.Response> where T : NetworkRequest {
            onRequestedComponents(request.urlComponents)
            return Promise { resolve, reject in
                
            }
        }
    }
    
    class MockImageService: ImageServiceProtocol {
        func fetchImage(from url: URL) -> Promise<UIImage> {
            return Promise { resolve, _ in
                resolve(UIImage())
            }
        }
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let networkService = MockNetworkService()
        let imageService = MockImageService()
        let viewModel = MovieListViewModel(networkService: networkService, imageService: imageService, loadMoreThreshold: 10)
        networkService.onRequestedComponents = { components in
            
        }
        _ = viewModel.loadDataForNextPage()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
