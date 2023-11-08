//
//  test.swift
//  DessertCategoryUITests
//
//  Created by Salmdo on 11/7/23.
//

import XCTest
@testable import DessertCategory

final class TestPerformance: XCTestCase {

    private var app: XCUIApplication!
    private var mealListPageObject: MealListPageObject?
    private var mealDetailsPageObject: MealDetailsPageObject?

    override func setUp() {
        app = XCUIApplication()
        mealListPageObject = MealListPageObject(app: app)
        mealDetailsPageObject = MealDetailsPageObject(app: app)
        continueAfterFailure = false
    }
    override func tearDown() {
        app = nil
        mealListPageObject = nil
        mealDetailsPageObject = nil
    }
    
    private func performNavigaFromMealListToMealDetails(){
        app.launch()
        let scrollView = mealListPageObject?.mealScrollView.firstMatch
        
        let name = mealListPageObject!.mealName.firstMatch
        
        if !name.isHittable {
            scrollView!.swipeUp()
        }
        name.tap()
    }
    
    func testCalculateWithCPUMetric() {
        measure(metrics: [XCTCPUMetric(application: app)]) {
            performNavigaFromMealListToMealDetails()
        }
    }
    
    func testCalculateWithMemoryMetric() {
        measure(metrics: [XCTMemoryMetric(application: app)]) {
            performNavigaFromMealListToMealDetails()
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                performNavigaFromMealListToMealDetails()
            }
        }
    }
}
