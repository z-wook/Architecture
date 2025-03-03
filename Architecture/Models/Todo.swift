//
//  Todo.swift
//  Architecture
//
//  Copyright (c) 2025 z-wook. All right reserved.
//

import Foundation

struct Todo {
    let id: UUID
    var title: String
    var date: Date = Date()
    var done: Bool = false
}
