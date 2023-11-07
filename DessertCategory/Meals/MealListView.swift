//
//  MealListView.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import SwiftUI

struct MealListView: View {
    @ObservedObject var mealListVM: MealListViewModel
    
    init(urlSession: URLSession = URLSession.shared) {
        self.mealListVM = MealListViewModel(urlSession: urlSession)
    }
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(mealListVM.mealList, id: \.id) { item in
                    NavigationLink {
                        MealDetailsView()
                    } label: {
                        VStack{
                            
                            AsyncImage(url: URL(string: item.image ?? "")) { img in
                                img.resizable()
                                    .scaledToFill().frame(width: 100, height: 100)
                            } placeholder: {
                                Image(systemName: "photo")
                            }

                            Text(item.name ?? "")
                        }
                    }

                    
                }
            }
        }
            .onAppear(){
                mealListVM.fetchMeals()
            }
    }
        
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
