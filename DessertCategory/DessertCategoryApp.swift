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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
