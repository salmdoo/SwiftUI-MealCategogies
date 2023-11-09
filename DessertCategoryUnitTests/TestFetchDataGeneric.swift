//
//  DessertCategoryUnitTests.swift
//  DessertCategoryUnitTests
//
//  Created by Salmdo on 11/6/23.
//

import XCTest
@testable import DessertCategory

final class TestFetchDataGeneric: XCTestCase {
    var config: URLSessionConfiguration?
    var urlSession: URLSession?
    
    override func setUp() {
        config = URLSessionConfiguration.ephemeral
        config?.protocolClasses = [MockFetchDataGeneric.self]
        urlSession = URLSession(configuration: config!)
        TestObject.successObject = TestObject(name: "Check")
    }
    
    override func tearDown() {
        config = nil
        urlSession = nil
        MockFetchDataGeneric.responseData = nil
        MockFetchDataGeneric.responseError = nil
        TestObject.successObject = nil
    }
    

    class TestObject: DecodeDataProtocol, Equatable{
        static func == (lhs: TestFetchDataGeneric.TestObject, rhs: TestFetchDataGeneric.TestObject) -> Bool {
            return lhs.name == rhs.name
        }
        
        let name: String
        
        init(name: String) {
            self.name = name
        }
        
        static var successObject: TestObject?
        
        typealias T = TestFetchDataGeneric.TestObject
        
        static func decodeData(data: Data) -> Result<TestFetchDataGeneric.TestObject, DessertCategory.NetworkError> {
            return .success(successObject ?? TestObject(name: ""))
        }
        
    }
    
    class TestObjectFailed: DecodeDataProtocol{
        let name: String
        
        init(name: String) {
            self.name = name
        }
        
        typealias T = TestFetchDataGeneric.TestObject
        
        static func decodeData(data: Data) -> Result<TestFetchDataGeneric.TestObject, DessertCategory.NetworkError> {
            return .failure(NetworkError.decodedFailed)
        }
        
    }
    
    func testFetchDataGeneric_InvalidUrl_ReturnFailure() async {
        MockFetchDataGeneric.responseError = NetworkError.invalidUrl
        
        let expectation = self.expectation(description: "Fetch Data is failed because of invalidUrl")
        let fetchDataGeneric = FetchDataGeneric<TestObject>(urlSession: urlSession!, urlApi: "String")
        
        let result = await fetchDataGeneric.fetchData()
        
        switch result {
        case .failure(let err):
            XCTAssertEqual(NetworkError.invalidUrl, err)
        default:
            XCTFail("Expected invalidUrl error but it does not")
        }
        expectation.fulfill()
        
       await  self.fulfillment(of: [expectation], timeout: 10)
    }
    
    func testFetchDataGeneric_DataNotFound_ReturnFailure() async {
        MockFetchDataGeneric.responseError = NetworkError.dataNotFound
        
        let expectation = self.expectation(description: "Fetch Data is failed because of dataNotFound")
        let fetchDataGeneric = FetchDataGeneric<TestObject>(urlSession: urlSession!, urlApi: "https://example.com")
        
        let result = await fetchDataGeneric.fetchData()
        switch result {
            case .failure(let err):
                XCTAssertEqual(NetworkError.dataNotFound, err)
            default:
                XCTFail("Expected dataNotFound error but it does not")
        }
        expectation.fulfill()
        await self.fulfillment(of: [expectation], timeout: 10)
    }
    
//    func testFetchDataGeneric_DecodedFailed_ReturnFailure() async {
//        
//        let expectedResultStr = "[{\"_id\":\"123\"}]"
//        MockFetchDataGeneric.responseData = expectedResultStr.data(using: .utf8)
//        
//        let expectation = self.expectation(description: "Fetch Data is failed because of decodedFailed")
//        let fetchDataGeneric = FetchDataGeneric<TestObjectFailed>(urlSession: urlSession!)
//        Task {
//            let result = await fetchDataGeneric.fetchData(urlString: "https://example.com/api")
//            switch result {
//            case .failure(let err):
//                XCTAssertEqual(NetworkError.decodedFailed, err)
//            default:
//                XCTFail("Expected decodedFailed error but it does not")
//                expectation.fulfill()
//            }
//        }
//        await self.fulfillment(of: [expectation], timeout: 10)
//    }
//    
//    func testFetchDataGeneric_ValidData_ReturnSuccess() async {
//        let expectedResultStr = "[{\"name\":\"Check\"}]"
//        MockFetchDataGeneric.responseData = expectedResultStr.data(using: .utf8)
//        
//        let expectation = self.expectation(description: "Fetch Data is success")
//        
//        let fetchDataGeneric = FetchDataGeneric<TestObject>(urlSession: urlSession!)
//        let result = await fetchDataGeneric.fetchData(urlString: "https://example.com/api")
//        switch result {
//        case .success(let res):
//            XCTAssertEqual(res, TestObject(name: "Check"))
//        default:
//            XCTFail("Expected success but it does not")
//        }
//        expectation.fulfill()
//        await self.fulfillment(of: [expectation], timeout: 10)
//    }
}
