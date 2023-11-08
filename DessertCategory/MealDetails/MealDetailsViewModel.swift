//
//  MealDetailsViewModel.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation
import OSLog

class MealDetailsViewModel: ObservableObject {
    @Published var mealDetails: MealDetails? = nil
    @Published var loadDataFailed = false
    
    var mealId: String
    
    private let fetchDataGeneric: FetchDataGeneric<MealDetails>?
    private let logging: Logger?
    
    var networkReponseString: String  = NSLocalizedString("No message", comment: "No message")
    
    init(fetchData: any FetchDataProtocol, mealId: String) {
        fetchDataGeneric = fetchData as? FetchDataGeneric<MealDetails>
        self.mealId = mealId
        logging = HandleLogging.instance
    }
    
    func fetchData() async {
       let result = await fetchDataGeneric?.fetchData(urlString: APIEndpoint.getDesertDetails(mealId))
        
        DispatchQueue.main.async {
            guard let result else {return}
            
            switch result {
            case .success(let meal):
                if let meal {
                    self.mealDetails = meal
                    self.loadDataFailed = false
                } else {
                    self.logging?.error("MealDetailsViewModel - fetchMeals - no meals are returned")
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
