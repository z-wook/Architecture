//
//  MainViewModel.swift
//  Architecture
//
//  Copyright (c) 2025 z-wook. All right reserved.
//

import Foundation

final class MainViewModel {
    var updateTodoList: (() -> Void)?
    
    enum SectionType: Int, CaseIterable {
        case undone
        case done
    }
    
    private var todoList: [Todo] = [] {
        didSet {
            updateTodoList?()
        }
    }
    
    func getSectionCount() -> Int {
        return SectionType.allCases.count
    }
    
    func getTodo(indexPath: IndexPath) -> Todo {
        let sectionType = SectionType(rawValue: indexPath.section) ?? .undone
        
        switch sectionType {
        case .done:
            let todos = todoList.filter { $0.done == true }
            return todos[indexPath.row]
            
        case .undone:
            let todos = todoList.filter { $0.done == false }
            return todos[indexPath.row]
        }
    }
    
    func createTodo(title: String) {
        let todo = Todo(id: UUID(), title: title)
        addTodo(todo: todo)
    }
    
    func reverseDone(id: UUID) {
        if let index = todoList.firstIndex(where: { $0.id == id }) {
            todoList[index].done.toggle()
        }
    }
    
    func deleteTodo(id: UUID) {
        if let index = todoList.firstIndex(where: { $0.id == id }) {
            todoList.remove(at: index)
        }
    }
    
    func getNumberOfRowInSection(sectionType: SectionType) -> Int {
        return todoList.filter { $0.done == (sectionType == .done) }.count
    }
}

private extension MainViewModel {
    func addTodo(todo: Todo) {
        todoList.insert(todo, at: 0)
    }
}
