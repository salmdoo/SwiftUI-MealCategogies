//
//  MealListViewModel.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation
import OSLog

class MealListViewModel: ObservableObject {
    @Published var mealList: [Meal] = []
    @Published var loadDataFailed = false
    
    var networkReponseString: String  = NSLocalizedString("No message", comment: "No message")
    
    private let fetchDataGeneric: FetchMealsProtocol
    private let logging: Logger?

    init(fetchData: FetchMealsProtocol) {
        logging = HandleLogging.instance
        self.fetchDataGeneric = fetchData
        Task {
            await fetchMeals()
        }
    }
    
    func fetchMeals() async {
        let result = await fetchDataGeneric.fetchData()
        
        DispatchQueue.main.async {
            switch result {
            case .success(let res):
                if let meals = res?.meals {
                    self.mealList = meals.sorted(by: { $0.name! < $1.name! })
                    self.loadDataFailed = false
                } else {
                    self.logging?.error("MealListViewModel - fetchMeals - no meals are returned")
                    self.networkReponseString = NetworkError.dataNotFound.localizedString
                    self.loadDataFailed = true
                }
            case .failure(let err):
                self.logging?.error("MealListViewModel - fetchMeals - \(err)")
                self.networkReponseString = err.localizedString
                self.loadDataFailed = true
            }
        }
    }
    
}
