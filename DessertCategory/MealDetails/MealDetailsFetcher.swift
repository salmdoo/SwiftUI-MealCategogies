//
//  MealDetailsFetcher.swift
//  DessertCategory
//
//  Created by Salmdo on 11/8/23.
//

import Foundation
import SwiftUI
import CoreData

protocol FetchMealDetailsProtocol {
    func fetchData() async -> Result<MealDetails?, NetworkError>
}

struct MealDetailsAPIFetcher: FetchMealDetailsProtocol {
    
    private let fetchDataGeneric: FetchDataGeneric<MealDetails>
    
    init (urlSession: URLSession, mealId: String)
    {
        let urlApi = APIEndpoint.getDesertDetails(mealId)
        fetchDataGeneric = FetchDataGeneric<MealDetails>(urlSession: urlSession, urlApi: urlApi)
    }
    
    func fetchData() async -> Result<MealDetails?, NetworkError> {
        await fetchDataGeneric.fetchData()
    }
}

struct MealDetailsCodeDataFetcher: FetchMealDetailsProtocol {
    private let persistence = PersistenceController.instance
    var mealId: String
    
    func fetchData() async -> Result<MealDetails?, NetworkError> {
        let result = persistence.fetchData()
        print(mealId)
        switch result {
        case .success(let res):
            let meal = res.filter { $0.id == mealId }.map { MealDetails(id: $0.id ?? "", name: $0.name ?? "" , instructions: $0.instructions ?? "", image: $0.image ?? "", ingredients: [:]) }.first
            return .success(meal)
        case .failure(let err):
            return .failure(err)
        }
    }
}
