//
//  MealDetailsView.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import SwiftUI
import CoreData

struct MealDetailsView: View {
    @StateObject var mealDetailsVM: MealDetailsViewModel
    
    
    init(fetcher: FetchMealDetailsProtocol) {
        self._mealDetailsVM = StateObject(wrappedValue:MealDetailsViewModel(fetchData: fetcher))
    }
    
    var body: some View {
        ScrollView {
            if mealDetailsVM.mealDetails.id == nil {
                EmptyView()
            }
            else {
                LazyVStack(alignment: .leading) {
                    HStack {
                        if let image = mealDetailsVM.mealDetails.image {
                            CustomImage(url: image, maxWidth: 100, maxHeight: 100)
                        }
                        
                        if let name = mealDetailsVM.mealDetails.name {
                            Text(name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    if let instructions = mealDetailsVM.mealDetails.instructions {
                        Text(instructions)
                            .font(.caption)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                    }
                        
                    if let ingredients = mealDetailsVM.mealDetails.ingredients, ingredients.count > 0 {
                        Text("Ingredient")
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                            .accessibilityIdentifier("mealIngredient")
                        
                        ForEach(ingredients.keys.sorted(), id: \.self) { key in
                            HStack {
                                Text(key)
                                    .font(.caption2)
                                Spacer()
                                if let key = ingredients[key] {
                                    Text(key)
                                        .font(.caption2)
                                }
                            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
                            
                        }
                    }
                        
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .alert("Important Message", isPresented: $mealDetailsVM.loadDataFailed, actions: {
            Text("Reload application")
        }, message: {
            Text(mealDetailsVM.networkReponseString)
        })
        .refreshable(action: {
            await mealDetailsVM.fetchMealDetails()
        })
        .task {
            await mealDetailsVM.fetchMealDetails()
        }
    }
}

struct MealDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsView(fetcher: MealDetailsCoreDataFetcher(mealId: "mealId"))
    }
}
