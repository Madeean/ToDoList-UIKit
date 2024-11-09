//
//  TaskListViewModel.swift
//  TaskList
//
//  Created by made reihan on 09/11/24.
//

import Foundation

class TaskListViewModel {
    var tasks = [TaskViewModel]()
    
    init() {
        getAll()
    }
    
    var numberOfTask: Int {
        tasks.count
    }
    
    func getAll() {
        
    }
    
    func numberOfRows(by section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return numberOfTask
    }
    
    func getTasksByType() -> (complete: Int, Incomplete: Int) {
        let completedCount = tasks.lazy.filter({ $0.completed }).count
        let inCompletedCount = tasks.lazy.filter({ !$0.completed }).count
        
        return (completedCount, inCompletedCount)
    }
    
    func task(index: Int) -> TaskViewModel {
        return tasks[index]
    }
    
    func toggleCompleted(task: TaskViewModel) {
        getAll()
    }
    
    func deleteItem(task: TaskViewModel) {
        getAll()
    }
}
