//
//  TestMealDetails.swift
//  DessertCategoryUnitTests
//
//  Created by Salmdo on 11/7/23.
//

import XCTest
@testable import DessertCategory

final class TestMealDetails: XCTestCase {

    func testMealDetails_DecodedFailed_ReturnFailure(){
        
        let res = MealDetails.decodeData(data: Data())
        switch res {
        case .failure(let err):
            XCTAssertEqual(err, NetworkError.decodedFailed)
        default:
            XCTFail("Expected decodedFailed error but it does not")
        }
    }
    
    func testMealDetails_DataNotFound_ReturnFailure(){
        let dataString = "{\"name\":\"Check\"}"
        let inputData = dataString.data(using: .utf8)
        
        let res = MealDetails.decodeData(data: inputData!)
        switch res {
        case .failure(let err):
            XCTAssertEqual(err, NetworkError.dataNotFound)
        default:
            XCTFail("Expected decodedFailed error but it does not")
        }
    }
    
    func testMealDetails_ValidData_ReturnSuccess(){
        let dataString = "{\"meals\":[{\"strMeal\":\"Apam\",\"strInstructions\":\"check\",\"strMealThumb\":\"https://www.example.com\",\"strIngredient1\":\"Milk\",\"strIngredient2\":\"Eggs\",\"strMeasure1\":\"200ml\",\"strMeasure2\":\"60ml\",}]}"
        let inputData = dataString.data(using: .utf8)
        
        var expectResult = MealDetails()
        expectResult.name = "Apam"
        expectResult.instructions = "check"
        expectResult.image = "https://www.example.com"
        expectResult.ingredients.updateValue("200ml", forKey:"Milk" )
        expectResult.ingredients.updateValue("60ml", forKey: "Eggs")
        
        let res = MealDetails.decodeData(data: inputData!)
        switch res {
        case .success(let res):
            XCTAssertEqual(res, expectResult)
        default:
            XCTFail("Expected success but it does not")
        }
    }

}
