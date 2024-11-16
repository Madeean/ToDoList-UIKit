//
//  ViewController.swift
//  TaskList
//
//  Created by made reihan on 09/11/24.
//

import CoreData
import UIKit

class ToDoListViewController: UIViewController {
    
    let viewModel = TaskListViewModel()
    
    lazy var celebrateAnimationView: CelebrationAnimationView = {
       let v = CelebrationAnimationView(fileName: "animationLottie")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        return v
    }()
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dataSource = self
        v.delegate = self
        v.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        v.register(SummaryTableViewCell.self, forCellReuseIdentifier: "SummaryCell")
        v.estimatedRowHeight = 200
        v.rowHeight = UITableView.automaticDimension
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "Madee"
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        view.addSubview(celebrateAnimationView)
        NSLayoutConstraint.activate([
            celebrateAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            celebrateAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            celebrateAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            celebrateAnimationView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAll()
        tableView.reloadData()
//        celebrateAnimationView.play { finished in
//            print("Done")
//        }
    }

    @objc
    func addNewTask() {
        navigationController?.pushViewController(AddNewTaskViewController(), animated: true)
    }
}

// class ToDoListViewController: UIViewController {
//    lazy var addNewButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("Add Task", for: .normal)
//        v.setTitleColor(.black, for: .normal)
//        v.addTarget(self, action: #selector(addNewTask(sender:)), for: .touchUpInside)
//        return v
//    }()
//
//    lazy var getTasksButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("Get Task", for: .normal)
//        v.setTitleColor(.black, for: .normal)
//        v.addTarget(self, action: #selector(getTasks(sender:)), for: .touchUpInside)
//        return v
//    }()
//
//    lazy var toggleCompleteButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("Mark Task Complete", for: .normal)
//        v.setTitleColor(.black, for: .normal)
//        v.addTarget(self, action: #selector(markCompleted(sender:)), for: .touchUpInside)
//        return v
//    }()
//
//    lazy var deleteTaskButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("delete task", for: .normal)
//        v.setTitleColor(.black, for: .normal)
//        v.addTarget(self, action: #selector(deleteTask(sender:)), for: .touchUpInside)
//        return v
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.systemBackground
//        title = "Madee"
//
//        [addNewButton, getTasksButton, toggleCompleteButton, deleteTaskButton].forEach {control in
//            view.addSubview(control)
//        }
//
//        NSLayoutConstraint.activate([
//            addNewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            addNewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            addNewButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//
//            getTasksButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            getTasksButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            getTasksButton.topAnchor.constraint(equalTo: addNewButton.bottomAnchor, constant: 8),
//
//            toggleCompleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            toggleCompleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            toggleCompleteButton.topAnchor.constraint(equalTo: getTasksButton.bottomAnchor, constant: 8),
//
//            deleteTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            deleteTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            deleteTaskButton.topAnchor.constraint(equalTo: toggleCompleteButton.bottomAnchor, constant: 8),
//        ])
//    }
//
//    @objc
//    func addNewTask(sender: UIButton) {
//        CoreDataManager.shared.addNewTask(name: "new task", dueOn: Date().addingTimeInterval(100000))
//    }
//
//    @objc
//    func getTasks(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            print(task.name ?? "kosong")
//        }
//    }
//
//    @objc
//    func markCompleted(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            CoreDataManager.shared.toggleCompleted(id: task.id ?? UUID())
//        }
//
//        let fetchedTask = CoreDataManager.shared.getAll()
//        for task in fetchedTask {
//            print("\(task.name ?? "") : \(task.completed), \(task.completeOn?.formatted(date: .abbreviated, time: .omitted) ?? "") ")
//        }
//    }
//
//    @objc
//    func deleteTask(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            CoreDataManager.shared.delete(id: task.id ?? UUID())
//        }
//
//        let fetchedTask = CoreDataManager.shared.getAll()
//        print(fetchedTask.count)
//        for task in fetchedTask {
//            print("\(task.name ?? "") : \(task.completed), \(task.completeOn?.formatted(date: .abbreviated, time: .omitted) ?? "") ")
//        }
//    }
// }
