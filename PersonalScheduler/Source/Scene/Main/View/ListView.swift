//
//  ListView.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

class ListView: UIView {
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView(with mainViewController: MainViewController) {
        listTableView.delegate = mainViewController
        listTableView.dataSource = mainViewController
    }
    
    func reloadTableViewData() {
        listTableView.reloadData()
    }
    
    private func configureLayout() {
        addSubview(listTableView)
        
        NSLayoutConstraint.activate([
            listTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listTableView.topAnchor.constraint(equalTo: topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
