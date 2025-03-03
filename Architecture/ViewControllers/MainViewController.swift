//
//  MainViewController.swift
//  Architecture
//
//  Copyright (c) 2025 z-wook. All right reserved.
//

import UIKit

final class MainViewController: UIViewController {
    private let mainView: MainView = MainView()
    private let mainViewModel: MainViewModel
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        bindViewModel()
        setupTableView()
    }
}

private extension MainViewController {
    func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "TodoList"
        
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMemo))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func setupTableView() {
        mainView.todoTableView.dataSource = self
    }
    
    func bindViewModel() {
        mainViewModel.updateTodoList = { [weak self] in
            self?.mainView.todoTableView.reloadData()
        }
    }
    
    @objc func addMemo() {
        let alert = UIAlertController(title: "Add Todo", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self?.mainViewModel.createTodo(title: text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addTextField()
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainViewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = MainViewModel.SectionType(rawValue: section) ?? .undone
        return mainViewModel.getNumberOfRowInSection(sectionType: sectionType)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = MainViewModel.SectionType(rawValue: section) ?? .undone
        return sectionType == .undone ? "Not Done" : "Done"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier,
                                                       for: indexPath) as? TodoCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let todo = mainViewModel.getTodo(indexPath: indexPath)
        cell.setTodo(todo: todo)
        
        // MARK: - Closure 사용 방법
//        cell.didTapCheckButton = { [weak self] id in
//            self?.mainViewModel.reverseDone(id: id)
//        }
//        
//        cell.didTapDeleteButton = { [weak self] id in
//            self?.mainViewModel.deleteTodo(id: id)
//        }
        
        // MARK: - delegate 사용 방법
        cell.delegate = self
        return cell
    }
}

extension MainViewController: TodoCellDelegate {
    func didTapCheckButton(id: UUID) {
        mainViewModel.reverseDone(id: id)
    }
    
    func didTapDeleteButton(id: UUID) {
        mainViewModel.deleteTodo(id: id)
    }
}
