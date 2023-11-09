//
//  MealDetailsViewModel.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation
import OSLog

class MealDetailsViewModel: ObservableObject {
    @Published var mealDetails: MealDetails
    @Published var loadDataFailed = false
    
    private let fetchData: FetchMealDetailsProtocol
    private let logging: Logger
    
    var networkReponseString: String  = NSLocalizedString("No message", comment: "No message")
    
    init(mealId: String, fetchData: FetchMealDetailsProtocol) {
        self.fetchData = fetchData
        mealDetails = MealDetails(id: mealId)
        logging = HandleLogging.instance
    }
    
    func fetchMealDetails() async {
        let result = await fetchData.fetchData()
        
        DispatchQueue.main.async {
            switch result {
            case .success(let meal):
                if let meal {
                    self.mealDetails = meal
                    self.loadDataFailed = false
                    self.cacheMeal(mealDetails: meal)
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
    
    private func cacheMeal(mealDetails: MealDetails){
        if fetchData is MealDetailsAPIFetcher {
            let persistence = PersistenceController.instance
            persistence.save(meal: mealDetails)
        }
    }
}
