//
//  MealDetailsView.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import SwiftUI

struct MealDetailsView: View {
    @ObservedObject var mealDetailsVM: MealDetailsViewModel
    
    init(urlSession: URLSession = .shared) {
        self.mealDetailsVM = MealDetailsViewModel(urlSession: urlSession)
    }
    var body: some View {
        ScrollView {
            LazyVStack {
                Image(systemName: "photo")
                    .resizable()
                    .frame(height: 250)
                Text(mealDetailsVM.mealDetails.name)
                Text("Instruction")
                Text(mealDetailsVM.mealDetails.instructions)
                Text("Ingredient")
                ForEach(mealDetailsVM.mealDetails.ingredients.keys.sorted(), id: \.self) { key in
                    LazyHStack {
                        Text(key)
                        Spacer()
                        Text(mealDetailsVM.mealDetails.ingredients[key] ?? "")
                    }
                }
                
            }
        }
        
            .onAppear(){
                mealDetailsVM.fetchData()
            }
    }
}

struct MealDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsView()
    }
}
