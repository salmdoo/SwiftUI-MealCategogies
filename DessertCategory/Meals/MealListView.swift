//
//  MealListView.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import SwiftUI

struct MealListView: View {
    let mealListVM: MealListViewModel?
    
    init(urlSession: URLSession = URLSession.shared) {
        self.mealListVM = MealListViewModel(urlSession: urlSession)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(){
                mealListVM?.fetchMeals()
            }
    }
        
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
