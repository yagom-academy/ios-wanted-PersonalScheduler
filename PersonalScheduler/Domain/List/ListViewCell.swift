//
//  ListViewCell.swift
//  PersonalScheduler
//
//  Created by 곽우종 on 2023/01/12.
//

import UIKit

final class ListViewCell: UITableViewCell {
    static let identifier = "\(ListViewCell.self)"
    
    private enum Constant {
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemYellow
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        
        contentView.addSubviews(
            titleLabel,
            dateLabel,
            contentsLabel
        )
        
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
            dateLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureCell(_ model: Schedule, row: Int) {
        titleLabel.text = model.title
        dateLabel.text = model.todoDate
        contentsLabel.text = model.contents
    }
}
