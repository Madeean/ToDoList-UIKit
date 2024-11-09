//
//  CoreDataManager.swift
//  TaskList
//
//  Created by made reihan on 09/11/24.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do{
                try context.save()
            } catch {
                let nsError = error as NSError
                print("Error saving the staged changes \(error), \(nsError.userInfo)")
            }
        }
    }
}
