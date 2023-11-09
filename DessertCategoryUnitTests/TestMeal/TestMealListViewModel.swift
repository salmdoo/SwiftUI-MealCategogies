//
//  TestMealListViewModel.swift
//  DessertCategoryUnitTests
//
//  Created by Salmdo on 11/7/23.
//

import XCTest
@testable import DessertCategory

final class TestMealListViewModel: XCTestCase {

    func testTestMealListViewModelSuccess(){
        let mealList = [Meal(id: "1", name: "1", image: "http:/sample.com")]
        let mockData = MealList(meals: mealList)

        let mockFetchData = MockFetchData<MealList>()
        mockFetchData.mockData = mockData

        let viewModel = MealListViewModel(fetchData: mockFetchData)

        let expectation = self.expectation(description: "Fetch Data is failed because of invalidUrl")
        viewModel.fetchMeals()

        DispatchQueue.main.async {
            XCTAssertEqual(mealList, viewModel.mealList)
            expectation.fulfill()
        }


        self.wait(for: [expectation], timeout: 10)
    }

}
