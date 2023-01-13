//
//  ScheduleCell.swift
//  PersonalScheduler
//
//  Created by bard on 2023/01/13.
//

import UIKit

final class ScheduleCell: UITableViewCell {
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.text = "생성일"
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    // MARK: - Methods
    
    func setupCell(with schedule: Schedule) {
        titleLabel.text = schedule.title
        bodyLabel.text = schedule.body
        createdDateLabel.text = schedule.createDate
    }
    
    private func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [titleLabel, createdDateLabel, bodyLabel]
            .forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        setupTitleLabelConstraints()
        setupCreateDateLableConstraints()
        setupBodyLabelConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 8
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 12
            )
        ])
    }
    
    private func setupCreateDateLableConstraints() {
        NSLayoutConstraint.activate([
            createdDateLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -8
            ),
            createdDateLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -12
            )
        ])
    }
    
    private func setupBodyLabelConstraints() {
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 12
            ),
            bodyLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            bodyLabel.trailingAnchor.constraint(
                equalTo: createdDateLabel.leadingAnchor,
                constant: -20
            ),
            bodyLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -8
            )
        ])
    }
}
