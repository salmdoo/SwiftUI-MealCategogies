//
//  ContentView.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var fetcher: FetchMealsProtocol
    
    var body: some View {
        NavigationView {
            MealListView(fetcher: fetcher)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(fetcher: MealCoreDataFetcher())
    }
}
