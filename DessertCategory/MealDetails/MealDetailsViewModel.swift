//
//  MealDetailsViewModel.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation
import OSLog

class MealDetailsViewModel: ObservableObject {
    @Published var mealDetails: MealDetails? = MealDetails()
    @Published var loadDataFailed = false
    
    private let fetchDataGeneric: FetchMealDetailsProtocol
    private let logging: Logger
    
    var networkReponseString: String  = NSLocalizedString("No message", comment: "No message")
    
    init(fetchData: FetchMealDetailsProtocol) {
        fetchDataGeneric = fetchData
        logging = HandleLogging.instance
    }
    
    func fetchData() async {
        let result = await fetchDataGeneric.fetchData()
        
        DispatchQueue.main.async {
            
            switch result {
            case .success(let meal):
                if let meal {
                    self.mealDetails = meal
                    self.loadDataFailed = false
                } else {
                    self.logging.error("MealDetailsViewModel - fetchMeals - no meals are returned")
                    self.networkReponseString = NetworkError.dataNotFound.localizedString
                    self.loadDataFailed = true
                }
            case .failure(let err):
                self.logging.error("MealListViewModel - fetchMeals - \(err)")
                self.networkReponseString = err.localizedString
                self.loadDataFailed = true
            }
        }
    }
}
