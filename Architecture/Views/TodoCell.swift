//
//  TodoCell.swift
//  Architecture
//
//  Copyright (c) 2025 z-wook. All right reserved.
//

import SnapKit
import UIKit

protocol TodoCellDelegate: AnyObject {
    func didTapCheckButton(id: UUID)
    func didTapDeleteButton(id: UUID)
}

final class TodoCell: UITableViewCell {
    static let identifier = "TodoCell"
    private var todo: Todo?
    
    // MARK: - delegate 사용 방법
    weak var delegate: TodoCellDelegate?
    
    // MARK: - Closure 사용 방법
//    var didTapCheckButton: ((UUID) -> Void)?
//    var didTapDeleteButton: ((UUID) -> Void)?
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setImage(Icons.circle, for: .normal)
        button.addTarget(self, action: #selector(selectCheckButton), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = ThemeFonts.bold20
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = ThemeFonts.regular16
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(Icons.trash, for: .normal)
        button.addTarget(self, action: #selector(selectDeleteButton), for: .touchUpInside)
        return button
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.size10
        return stack
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTodo(todo: Todo) {
        self.todo = todo
        titleLabel.text = todo.title
        dateLabel.text = todo.date.description
        
        if todo.done == true {
            checkButton.setImage(Icons.checkmark_circle_fill, for: .normal)
        } else {
            checkButton.setImage(Icons.circle, for: .normal)
        }
    }
}

private extension TodoCell {
    func setUI() {
        contentView.addSubview(hStack)
        
        [checkButton, vStack, deleteButton].forEach {
            hStack.addArrangedSubview($0)
        }
        
        [titleLabel, dateLabel].forEach {
            vStack.addArrangedSubview($0)
        }
        
        hStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.size16)
        }
    }
    
    @objc func selectCheckButton() {
        guard let todo else { return }
//        didTapCheckButton?(todo.id)
        delegate?.didTapCheckButton(id: todo.id)
    }
    
    @objc func selectDeleteButton() {
        guard let todo else { return }
//        didTapDeleteButton?(todo.id)
        delegate?.didTapDeleteButton(id: todo.id)
    }
}
