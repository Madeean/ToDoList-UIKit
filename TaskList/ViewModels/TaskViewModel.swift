//
//  TaskViewModel.swift
//  TaskList
//
//  Created by made reihan on 09/11/24.
//

import Foundation

struct TaskViewModel {
    private var task: Task

    init(task: Task) {
        self.task = task
    }

    var id: UUID {
        task.id ?? UUID()
    }

    var name: String {
        task.name ?? ""
    }

    var dueOn: Date {
        task.dueOn ?? Date()
    }

    var completedOn: Date {
        task.completeOn ?? Date()
    }

    var completed: Bool {
        task.completed
    }

}
