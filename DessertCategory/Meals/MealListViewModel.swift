//
//  MealListViewModel.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation

class MealListViewModel: ObservableObject {
    @Published var mealList: [Meal] = []
    private let fetchDataGeneric: FetchDataGeneric<MealList>!
    
    init(urlSession: URLSession) {
        self.fetchDataGeneric = FetchDataGeneric<MealList>(urlSession: urlSession)
    }
    
    func fetchMeals() {
        fetchDataGeneric.fetchData(urlString: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") { result in
            switch result {
            case .success(let res):
                self.mealList = res?.meals ?? []
            case .failure(let err):
                print(err)
            }
        }
        
    }
    
    
}
