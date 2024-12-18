//
//  ToDoListViewControllerDataSource.swift
//  TaskList
//
//  Created by made reihan on 16/11/24.
//

import UIKit

extension ToDoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(by: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryTableViewCell else {
                return UITableViewCell()
            }
            let taskSummary = viewModel.getTasksByType()
            cell.configure(completed: taskSummary.complete.description, incompleted: taskSummary.Incomplete.description)

            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        
        let task = viewModel.task(index: indexPath.row)
        cell.configure(task: task)
        
        return cell
    }
}
