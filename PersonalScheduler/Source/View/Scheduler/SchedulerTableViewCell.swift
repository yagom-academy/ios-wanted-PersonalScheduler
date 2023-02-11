//  PersonalScheduler - SchedulerTableViewCell.swift
//  Created by zhilly on 2023/02/09

import UIKit

final class SchedulerTableViewCell: UITableViewCell, ReusableView {
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        return label
    }()
    
    private let periodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    @available(*, unavailable)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        backgroundColor = UIColor(named: "AppColor")
    }
    
    private func setupLayout() {
        [titleLabel, bodyLabel, periodLabel].forEach(contentsStackView.addArrangedSubview(_:))
        contentView.addSubview(contentsStackView)
        
        NSLayoutConstraint.activate([
            contentsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(with item: Schedule) {
        titleLabel.text = item.title
        bodyLabel.text = item.body
        periodLabel.text = DateFormatter.convertToPeriod(start: item.startingDate, end: item.deadline)
    }
}
