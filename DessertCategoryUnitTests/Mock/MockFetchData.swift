//
//  MockFetchData.swift
//  DessertCategoryUnitTests
//
//  Created by Salmdo on 11/7/23.
//

import Foundation
@testable import DessertCategory

class MockFetchData<T> {
    var mockData: T?
    var mockError: NetworkError?
    
    func fetchData(urlString: String) async -> Result<T?, DessertCategory.NetworkError> {
        if let err = mockError {
            return Result.failure(err)
        } else {
            return Result.success(mockData)
        }
    }
}
