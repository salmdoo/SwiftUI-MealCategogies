//
//  MockFetchData.swift
//  DessertCategoryUnitTests
//
//  Created by Salmdo on 11/7/23.
//

import Foundation
@testable import DessertCategory

class MockFetchMealData: FetchMealsProtocol {
    
    var mockData: DessertCategory.MealList?
    var mockError: NetworkError?
    
    func fetchData() async -> Result<DessertCategory.MealList?, DessertCategory.NetworkError> {
        if let err = mockError {
            return Result.failure(err)
        } else {
            return Result.success(mockData)
        }
    }
}
