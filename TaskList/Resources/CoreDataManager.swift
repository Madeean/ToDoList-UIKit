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
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                print("Error saving the staged changes \(error), \(nsError.userInfo)")
            }
        }
    }

    func getAll() -> [Task] {
        var tasks = [Task]()

        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "dueOn", ascending: true)
        fetchRequest.sortDescriptors = [sortByDueDate]

        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }

        return tasks
    }

    func addNewTask(name: String, dueOn: Date) {
        let task = Task(context: context)
        task.name = name
        task.dueOn = dueOn
        task.id = UUID()
        task.completed = false
        task.completeOn = dueOn.advanced(by: 100000)

        saveContext()
    }

    func toggleCompleted(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate

        do {
//            let fetchedTasks = try context.fetch(fetchRequest)
//            for task in fetchedTasks {
//                task.completed = !task.completed
//                if task.completed {
//                    task.completeOn = Date()
//                }
//            }

            if let fetchedTask = try context.fetch(fetchRequest).first(where: { $0.id == id }) {
                fetchedTask.completed = !fetchedTask.completed
                if fetchedTask.completed {
                    fetchedTask.completeOn = Date()
                }
            }
            
            saveContext()

        } catch let error as NSError {
            print("Error togglein state: \(error.userInfo), \(error.localizedDescription)")
        }
    }
    
    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
        
        do {
            let fetchedTasks = try context.fetch(fetchRequest)
            for task in fetchedTasks {
                context.delete(task)
            }
            
            saveContext()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
 
