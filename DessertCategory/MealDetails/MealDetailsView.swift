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
    
    private var mealId: String
    
    init(mealId: String) {
        self.mealId = mealId
        var fetcher: FetchMealDetailsProtocol = MealDetailsCodeDataFetcher(mealId: mealId)
       
        let networkMonitor = NetworkMonitor.instance
        if networkMonitor.isConnected {
            fetcher = MealDetailsAPIFetcher(urlSession: .shared, mealId: mealId)
        }
        
        self._mealDetailsVM = StateObject(wrappedValue:MealDetailsViewModel(mealId: mealId, fetchData: fetcher))
    }
    
    var body: some View {
        ScrollView {
            if mealDetailsVM.mealDetails.name == "" {
                EmptyView()
            }
            else {
                LazyVStack(alignment: .leading) {
                    HStack {
                        CustomImage(url: mealDetailsVM.mealDetails.image, maxWidth: 100, maxHeight: 100)
                    
                        Text(mealDetailsVM.mealDetails.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                        }
                        Text(mealDetailsVM.mealDetails.instructions)
                            .font(.caption)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                        
                    if mealDetailsVM.mealDetails.ingredients.count > 0 {
                        Text("Ingredient")
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                            .accessibilityIdentifier("mealIngredient")
                        
                        ForEach(mealDetailsVM.mealDetails.ingredients.keys.sorted(), id: \.self) { key in
                            HStack {
                                Text(key)
                                    .font(.caption2)
                                Spacer()
                                Text(mealDetailsVM.mealDetails.ingredients[key] ?? "")
                                    .font(.caption2)
                            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
                            
                        }
                    }
                        
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .onAppear(){
        
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
        MealDetailsView(mealId: "53049")
    }
}
