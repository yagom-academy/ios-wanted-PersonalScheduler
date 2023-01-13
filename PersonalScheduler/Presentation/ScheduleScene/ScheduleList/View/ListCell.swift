//
//  ListCell.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/10.
//

import UIKit

final class ListCell: UICollectionViewCell {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 50, bottom: 0, right: 30)
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.setContentHuggingPriority(UILayoutPriority(100), for: .vertical)
        label.sizeToFit()
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private let plagView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.2
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialView()
        addSubviews()
        setupConstraints()
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with schedule: Schedule) {
        titleLabel.text = schedule.title
        bodyLabel.text = schedule.body
        setupDateLabel(from: schedule)
        setupPlagView(from: schedule)
    }
    
    private func setupInitialView() {
        backgroundColor = .systemBackground
    }
    
    private func setupDateLabel(from schedule: Schedule) {
        if schedule.endDate != "" {
            dateLabel.text = schedule.startDate + " ~ " + schedule.endDate!
        } else {
            dateLabel.text = schedule.startDate
        }
    }
    
    private func setupPlagView(from schedule: Schedule) {
        if schedule.isOnSchedule {
            plagView.backgroundColor = UIColor.green
        } else {
            plagView.backgroundColor = UIColor.black
        }
    }
}

private extension ListCell {
    
    func addSubviews() {
        contentView.addSubview(mainStackView)
        contentView.addSubview(plagView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(bodyLabel)
        mainStackView.addArrangedSubview(dateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            plagView.topAnchor.constraint(equalTo: contentView.topAnchor),
            plagView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            plagView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            plagView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
