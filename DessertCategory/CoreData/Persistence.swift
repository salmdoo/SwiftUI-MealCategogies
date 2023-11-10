//
//  Persistence.swift
//  testCD
//
//  Created by Salmdo on 11/8/23.
//

import CoreData
import SwiftUI
import OSLog

struct PersistenceController {
    static let instance = PersistenceController()
    private var logging = HandleLogging.instance

    private let fetchRequest: NSFetchRequest<MealCoreModel> = MealCoreModel.fetchRequest()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MealDataModel")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func fetchData() -> Result<[MealCoreModel], NetworkError> {
        let context = container.viewContext
        
        do {
            let results = try context.fetch(fetchRequest)
            return .success(results)
        } catch {
            return .failure(.dataNotFound)
        }
    }
    
    func save(meal: MealDetails){
        let results = fetchData()
        
        switch results {
        case .success(let res):
            if res.filter({ $0.id == meal.id }).count > 0 {
                logging.error("PersistenceController - save() - Do not save becase meal exists")
            } else {
                saveMeals(meal: meal)
            }
        default:
            logging.error("PersistenceController - save() - Cannot save meal")
        }
    }
    
    private func saveMeals(meal: MealDetails){
        if let id = meal.id {
            let context = container.viewContext
            let mealDetails = MealCoreModel(context: context)
            mealDetails.id = id
            mealDetails.name = meal.name
            mealDetails.instructions = meal.instructions
            
            do {
                try context.save()
            } catch {
                logging.error("PersistenceController - save() - Cannot save meal with meal id \(id) ")
            }
        }
    }
}
