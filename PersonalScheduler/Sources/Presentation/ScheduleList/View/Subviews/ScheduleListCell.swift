//
//  ScheduleListCell.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class ScheduleListCell: UITableViewCell {
    static var identifier = String(describing: ScheduleListCell.self)
    
    let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bodyView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addChildComponents()
        setUpLayout()
        setLayer()
    }
    
    private func setLayer() {
        layer.cornerRadius = 12
        layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        layer.borderWidth = 1
    }
    
    private func addChildComponents() {
        [titleView, bodyView, dateView].forEach(contentView.addSubview)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            dateView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            dateView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            dateView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            titleView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            titleView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 8),
            titleView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            bodyView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            bodyView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bodyView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
}
