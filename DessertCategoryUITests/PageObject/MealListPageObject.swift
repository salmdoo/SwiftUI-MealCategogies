//
//  MealListPageObject.swift
//  DessertCategoryUITests
//
//  Created by Salmdo on 11/7/23.
//

import XCTest

class MealListPageObject {
    var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var mealImage: XCUIElement {
        app.images["mealsViewImage"]
    }
    
    var mealName: XCUIElement {
        app.staticTexts["mealsViewName"]
    }
    
    var mealScrollView: XCUIElement {
        app.scrollViews["mealScrollListView"]
    }
}
