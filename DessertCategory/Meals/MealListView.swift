//
//  MealListView.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import SwiftUI

struct MealListView: View {
    @StateObject var mealListVM: MealListViewModel
    
    @State private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(fetcher: FetchMealsProtocol){        
        self._mealListVM = StateObject(wrappedValue:MealListViewModel(fetchData: fetcher))
    }
    
    private func mealDetailFetcher(mealId: String) -> FetchMealDetailsProtocol {
        var fetcher: FetchMealDetailsProtocol = MealDetailsCoreDataFetcher(mealId: mealId)
       
        let networkMonitor = NetworkMonitor.instance
        if networkMonitor.isConnected {
            fetcher = MealDetailsAPIFetcher(urlSession: .shared, mealId: mealId)
        }
        return fetcher
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(mealListVM.mealList, id: \.id) { item in
                    if let mealId = item.id {
                        NavigationLink {
                            MealDetailsView(fetcher: mealDetailFetcher(mealId: mealId))
                        } label: {
                            VStack (alignment: .leading) {
                                if let image = item.image {
                                    CustomImage(url: image, maxWidth: 150, maxHeight: 150)
                                        .accessibilityIdentifier("mealsViewImage")
                                }
                                
                                if let name = item.name {
                                    Text(name)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .padding(EdgeInsets(top: 1, leading: 5, bottom: 0, trailing: 0))
                                        .multilineTextAlignment(.leading)
                                        .accessibilityIdentifier("mealsViewName")
                                }
                                Spacer()
                            }.frame(width: 150, height: 210, alignment: .topLeading)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: item.image != nil ? 0 : 1)
                                })
                            
                        }
                    }
                }
            }
        }
        .onRotate(perform: { orientation in
            if orientation.isLandscape {
                columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
            } else {
                columns = [GridItem(.flexible()), GridItem(.flexible())]
            }
        })
        .alert("Important Message", isPresented: $mealListVM.loadDataFailed, actions: {
            Text("Reload application")
        }, message: {
            Text(mealListVM.networkReponseString)
        })
        .refreshable(action: {
            await mealListVM.fetchMeals()
        })
    .accessibilityIdentifier("mealScrollListView")
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(fetcher: MealAPIFetcher(urlSession: URLSession.shared))
    }
}
