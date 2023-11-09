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
    
    init(){
        let fetcher: FetchMealsProtocol
       
        let networkMonitor = NetworkMonitor.instance
        if networkMonitor.isConnected {
            fetcher = MealAPIFetcher(urlSession: URLSession.shared)
        } else {
            fetcher = MealCodeDataFetcher()
        }
        
        self._mealListVM = StateObject(wrappedValue:MealListViewModel(fetchData: fetcher))
    }
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(mealListVM.mealList, id: \.id) { item in
                    NavigationLink {
                        MealDetailsView(mealId: item.id ?? "")
                    } label: {
                        VStack (alignment: .leading) {
                            AsyncImage(url: URL(string: item.image ?? "")) { img in
                                img.resizable()
                                    .scaledToFit()
                                
                            } placeholder: {
                                Image(systemName: "photo")
                            }.frame(maxWidth: 150, maxHeight: 150)
                                .shadow(radius: 5)
                                .accessibilityIdentifier("mealsViewImage")
                            
                            Text(item.name ?? "")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .padding(EdgeInsets(top: 1, leading: 5, bottom: 0, trailing: 0))
                                .multilineTextAlignment(.leading)
                                .accessibilityIdentifier("mealsViewName")
                            Spacer()
                        }.frame(width: 150, height: 210, alignment: .topLeading)
                        
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
        MealListView()
    }
}
