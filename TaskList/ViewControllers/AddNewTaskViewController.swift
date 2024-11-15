//
//  AddNewTaskViewController.swift
//  TaskList
//
//  Created by made reihan on 15/11/24.
//

import UIKit

class AddNewTaskViewController: UIViewController {
    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Task Name"
        return label
    }()
    
    lazy var taskNameTextField: UITextField = {
       let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.placeholder = "Enter task name"
        v.borderStyle = .roundedRect
        return v
    }()
    
    lazy var dueOnLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Due On"
        return v
    }()
    
    lazy var dueOnDatePicker: UIDatePicker = {
        let v = UIDatePicker()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.datePickerMode = .date
        v.minimumDate = Date()
        return v
    }()
    
    let viewModel = AddNewTaskViewModel()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Add new task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        
        [taskNameLabel, taskNameTextField, dueOnLabel, dueOnDatePicker].forEach{ subViewToAdd in
            view.addSubview(subViewToAdd)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            taskNameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 8),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            dueOnLabel.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 8),
            dueOnLabel.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),
            
            dueOnDatePicker.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 8),
            dueOnDatePicker.trailingAnchor.constraint(equalTo: taskNameTextField.trailingAnchor, constant: 8),
        ])
    }
    
    @objc
    func saveTask(){
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Task name cant be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            
            return
        }
        
        let dueOn = dueOnDatePicker.date
        viewModel.addTask(name: taskName, dueOn: dueOn)
        
        let tasks = CoreDataManager.shared.getAll()
        for task in tasks {
            print(task.name ?? "kosong")
        }
        
        navigationController?.popViewController(animated: true)
    }
}
