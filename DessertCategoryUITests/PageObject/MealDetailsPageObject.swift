//
//  MealDetailsPageObject.swift
//  DessertCategoryUITests
//
//  Created by Salmdo on 11/7/23.
//

import XCTest

class MealDetailsPageObject {
    var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var mealInstruction: XCUIElement {
        app.staticTexts["mealIngredient"]
    }
}
