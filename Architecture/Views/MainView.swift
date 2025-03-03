//
//  MainView.swift
//  Architecture
//
//  Copyright (c) 2025 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class MainView: UIView {
    let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainView {
    func setUI() {
        addSubview(todoTableView)
        
        todoTableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.top.bottom.equalToSuperview()
        }
    }
}
