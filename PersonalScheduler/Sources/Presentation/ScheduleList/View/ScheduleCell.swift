//
//  ScheduleCell.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

final class ScheduleCell: UICollectionViewCell {
    
    private lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .leading, distribution: .fill, spacing: 20)
        stackView.backgroundColor = .clear
        stackView.addArrangedSubviews(monthLabel, topSeparatorView, infoStackView)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 20,
            trailing: 20
        )
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 20)
        stackView.backgroundColor = .clear
        stackView.addArrangedSubviews(dateView, colorSeparatorView, scheduleView)
        return stackView
    }()
    
    private lazy var bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        return view
    }()
    
    private lazy var colorSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .psSecondaryBackground
        view.widthAnchor.constraint(equalToConstant: 4).isActive = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var scheduleView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .leading, distribution: .fill, spacing: 4)
        stackView.backgroundColor = .clear
        stackView.addArrangedSubviews(titleLabel, descriptionLabel, dateLabel)
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(for: .body, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = .preferredFont(for: .body, weight: .regular)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(for: .body, weight: .regular)
        return label
    }()
    
    private lazy var dateView: DateView = {
        let view = DateView()
        return view
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(for: .body, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.isHidden = true
        return label
    }()
    
    private lazy var topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        view.widthAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.width - 40).isActive = true
        view.isHidden = true
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension ScheduleCell {
    
    func setUp(_ schedule: Schedule) {
        dateView.setUp(schedule.startDate)
        setUpDateLabel(schedule)
        titleLabel.text = schedule.title
        descriptionLabel.text = schedule.description
    }
    
    func highlight() {
        dateView.highlight()
        colorSeparatorView.backgroundColor = .psToday
    }
    
    func showMonthView(_ date: Date) {
        topSeparatorView.isHidden = false
        monthLabel.isHidden = false
        monthLabel.text = date.toString(.yearAndMonth)
    }
    
}

private extension ScheduleCell {
    
    func configure() {
        contentView.backgroundColor = .psBackground
        contentView.addSubviews(backgroundStackView, bottomSeparatorView)
        let constraints: [NSLayoutConstraint] = [
            backgroundStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            colorSeparatorView.heightAnchor.constraint(equalTo: scheduleView.heightAnchor)
        ]
        constraints.forEach { constraint in
            constraint.priority = .init(999)
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    func reset() {
        dateView.reset()
        colorSeparatorView.backgroundColor = .psSecondaryBackground
        titleLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
        topSeparatorView.isHidden = true
        monthLabel.isHidden = true
    }
    
    func setUpDateLabel(_ schedule: Schedule) {
        let start = schedule.startDate.toString(.hourMinute)
        let end = schedule.endDate.toString(schedule.hasOneMoreDay ? .hourMinuteDate : .hourMinute)
        dateLabel.text = "\(start) - \(end)"
        if schedule.isProgressing {
            highlight()
        }
    }
    
}
