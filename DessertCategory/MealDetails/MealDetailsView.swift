//
//  MealDetailsView.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import SwiftUI
import CoreData

struct MealDetailsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var mealDetailsVM: MealDetailsViewModel
    @State var fetcherObject: FetchMealDetailsProtocol? = nil
    
    private var mealId: String
    
    init(mealId: String) {
        self.mealId = mealId
        let fetcher: FetchMealDetailsProtocol
       
        let networkMonitor = NetworkMonitor.instance
        if networkMonitor.isConnected {
            fetcher = MealDetailsAPIFetcher(urlSession: .shared, mealId: mealId)
        } else {
            fetcher = MealDetailsCodeDataFetcher(mealId: mealId)
        }
        
        self._mealDetailsVM = StateObject(wrappedValue:MealDetailsViewModel(fetchData: fetcher))
    }
    
    var body: some View {
        ScrollView {
            if mealDetailsVM.mealDetails!.name == "" {
                EmptyView()
            }
            else {
                LazyVStack(alignment: .leading) {
                    HStack {
                        AsyncImage(url: URL(string: mealDetailsVM.mealDetails!.image )) { img in
                            img.resizable()
                        } placeholder: {
                            Image(systemName: "photo")
                        }.frame(width:100, height: 100)
                        .scaledToFill()
                    
                        Text(mealDetailsVM.mealDetails!.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                        }
                        Text(mealDetailsVM.mealDetails!.instructions)
                            .font(.caption)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                        
                    if mealDetailsVM.mealDetails!.ingredients.count > 0 {
                        Text("Ingredient")
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                            .accessibilityIdentifier("mealIngredient")
                        
                        ForEach(mealDetailsVM.mealDetails!.ingredients.keys.sorted(), id: \.self) { key in
                            HStack {
                                Text(key)
                                    .font(.caption2)
                                Spacer()
                                Text(mealDetailsVM.mealDetails!.ingredients[key] ?? "")
                                    .font(.caption2)
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
            await mealDetailsVM.fetchData()
        })
        .task {
            await mealDetailsVM.fetchData()
            saveMealDetails()
        }
    }
    
    private func saveMealDetails(){
        let mealDetails = MealCoreModel(context: self.viewContext)
        mealDetails.id = self.mealId
        mealDetails.name = mealDetailsVM.mealDetails?.name
        mealDetails.instructions = mealDetailsVM.mealDetails?.instructions
        
        do {
            try self.viewContext.save()
        } catch {
            print (error)
        }
    }
}

struct MealDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsView(mealId: "53049")
    }
}
