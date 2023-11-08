//
//  DessertCategoryUITests.swift
//  DessertCategoryUITests
//
//  Created by Salmdo on 11/7/23.
//

import XCTest
@testable import DessertCategory

final class TestMealListView: XCTestCase {
    private var app: XCUIApplication!
    private var mealListPageObject: MealListPageObject?
    private var mealDetailsPageObject: MealDetailsPageObject?

    override func setUp() {
        app = XCUIApplication()
        mealListPageObject = MealListPageObject(app: app)
        mealDetailsPageObject = MealDetailsPageObject(app: app)
        continueAfterFailure = false
        app.launch()
    }
    override func tearDown() {
        app = nil
        mealListPageObject = nil
        mealDetailsPageObject = nil
    }
    
    func testLaunchApp(){
        XCTAssertTrue(mealListPageObject!.mealImage.exists)
        XCTAssertTrue(mealListPageObject!.mealName.exists)
    }
    
    func testMealList_NavigateTo_MealDetails(){
        let scrollView = mealListPageObject?.mealScrollView.firstMatch
        XCTAssertTrue(scrollView!.exists)
        
        let name = mealListPageObject!.mealName.firstMatch
        XCTAssertTrue(name.exists)
        
        if !name.isHittable {
            scrollView!.swipeUp()
        }
        name.tap()
        
        //Randorm check
        let mealName = mealDetailsPageObject!.mealInstruction
        XCTAssertTrue(mealName.waitForExistence(timeout: 0.5))
    }
}
