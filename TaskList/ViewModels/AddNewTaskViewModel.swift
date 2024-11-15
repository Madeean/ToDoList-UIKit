//
//  AddNewTask.swift
//  TaskList
//
//  Created by made reihan on 09/11/24.
//

import Foundation

class AddNewTaskViewModel {
    func addTask(name: String, dueOn: Date) {
        CoreDataManager.shared.addNewTask(name: name, dueOn: dueOn)
    }
        
}
