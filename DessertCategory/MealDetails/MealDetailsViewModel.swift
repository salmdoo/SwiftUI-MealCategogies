//
//  MealDetailsViewModel.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation

class MealDetailsViewModel: ObservableObject {
    @Published var mealDetails = MealDetails()
    
    private let fetchDataGeneric: FetchDataGeneric<MealDetails>?
    
    init(urlSession: URLSession) {
        fetchDataGeneric = FetchDataGeneric(urlSession: urlSession)
    }
    
    func fetchData() {
        fetchDataGeneric?.fetchData(urlString: "https://themealdb.com/api/json/v1/1/lookup.php?i=52891", completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let res):
                    self.mealDetails = res ?? MealDetails()
                    print(self.mealDetails)
                case .failure(let err):
                    print(err)
                }
            }
        })
    }
}
