//
//  ListView.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

final class ListView: UIView {
    
    // MARK: Private Properties
    
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return tableView
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.add, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal Methods
    
    func configureTableView(with listViewController: ListViewController) {
        listTableView.delegate = listViewController
        listTableView.dataSource = listViewController
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
    
    func configureAddButton(target: UIViewController, action: Selector) {
        addButton.addTarget(target, action: action, for: .touchDown)
    }
    
    // MARK: Private Methods
    
    private func configureLayout() {
        addSubview(listTableView)
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            listTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listTableView.topAnchor.constraint(equalTo: topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
