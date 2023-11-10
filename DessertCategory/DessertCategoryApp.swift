//
//  DessertCategoryApp.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import SwiftUI

@main
struct DessertCategoryApp: App {
    let persistenceController = PersistenceController.instance
    let networkMonitor = NetworkMonitor.instance
    
    func fetchData() -> FetchMealsProtocol {
        var fetcher : FetchMealsProtocol = MealCoreDataFetcher()
        if networkMonitor.isConnected {
            fetcher = MealAPIFetcher(urlSession: URLSession.shared)
        }
        return fetcher
    }
    var body: some Scene {
        WindowGroup {
            ContentView(fetcher: fetchData())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
