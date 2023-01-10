//
//  ScheduleListV.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import UIKit

class ScheduleListV: UIView, BaseView {
    
    lazy var scheduletableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubview(scheduletableView)
    }
}
// MARK: - Constraints
extension ScheduleListV {
    
    func constraints() {
        let layout = [
            self.scheduletableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scheduletableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scheduletableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scheduletableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(layout)
    }
}
