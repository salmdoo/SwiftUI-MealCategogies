//
//  TestMealModel.swift
//  DessertCategoryUnitTests
//
//  Created by Salmdo on 11/7/23.
//

import XCTest
@testable import DessertCategory

final class TestMealModel: XCTestCase {
    
    func testMealModel_DecodedFailed_ReturnFailure(){
        let dataString = "{\"noMeal\":[]}"
        let inputData = dataString.data(using: .utf8)
        
        let res = MealList.decodeData(data: inputData!)
        switch res {
        case .failure(let err):
            XCTAssertEqual(err, NetworkError.decodedFailed)
        default:
            XCTFail("Expected decodedFailed error but it does not")
        }
        
    }
    
    func testMealModel_ValidData_ReturnSuccess(){
        let dataString = "{\"meals\":[{\"strMeal\":\"Apam\",\"strMealThumb\":\"https://example.com\",\"idMeal\":\"1\"}]}"
        let inputData = dataString.data(using: .utf8)
        
        let expectedResult = MealList(meals: [Meal(id: "1",name: "Apam",image: "https://example.com" )])
        
        let res = MealList.decodeData(data: inputData!)
        switch res {
        case .success(let res):
            XCTAssertEqual(res, expectedResult)
        default:
            XCTFail("Expected success but it does not")
        }
    }

}
