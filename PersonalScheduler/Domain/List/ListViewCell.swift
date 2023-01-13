//
//  ListViewCell.swift
//  PersonalScheduler
//
//  Created by 곽우종 on 2023/01/12.
//

import UIKit

final class ListViewCell: UITableViewCell {
    static let identifier = "\(ListViewCell.self)"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.text = "제목"
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemYellow
        label.text = "날짜"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.numberOfLines = 3
        label.text = "내용"
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
        backgroundColor = .white
        selectionStyle = .none
        contentView.addSubviews(
            titleLabel,
            dateLabel,
            contentsLabel
        )
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contentsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            contentsLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            contentsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureCell(_ model: Schedule) {
        if let title = model.title,
           let date = model.todoDate,
           let contents = model.contents
        {
            titleLabel.text = title
            dateLabel.text = "실행일: " + date
            contentsLabel.text = contents
            checkDate(date: date)
        }
    }
    
    private func checkDate(date: String) {
        guard let checkDate = date.toDate else {
            return
        }
        if checkDate < Date() {
            backgroundColor = .gray
            return
        }
        let hourDiff = Calendar.current.dateComponents([.hour], from: Date(), to: checkDate).hour
        if let hourDiff = hourDiff, hourDiff < 24, hourDiff >= 0 {
            backgroundColor = .green
        } else {
            backgroundColor = .white
        }
    }
}
