//
//  MealDetailsView.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import SwiftUI

struct MealDetailsView: View {
    @ObservedObject var mealDetailsVM: MealDetailsViewModel
    
    init(urlSession: URLSession = .shared, mealId: String) {
        self.mealDetailsVM = MealDetailsViewModel(fetchData: FetchDataGeneric<MealDetails>(urlSession: urlSession), mealId: mealId)
    }
    
    var body: some View {
        ScrollView {
            if mealDetailsVM.mealDetails == nil {
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
                        
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .onRotate(perform: { _ in
            print("Detail on rotate")
            Task {
                await mealDetailsVM.fetchData()
            }
        })
        .onAppear(){
            print("Detail on appear")
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
        }
    }
}

struct MealDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsView(mealId: "53049")
    }
}
