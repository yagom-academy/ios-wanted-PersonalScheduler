//
//  ScheduleCollectionViewCell.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import UIKit

final class ScheduleCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: ScheduleCollectionViewCell.self)

    private let stateBar: UIView = {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(schedule: Schedule) {
        titleLabel.text = schedule.title
        descriptionLabel.text = schedule.description
        startTimeLabel.text = schedule.startDate.toString()
        endTimeLabel.text = schedule.endDate.toString()
    }

    private func layout() {
        [stateBar, titleLabel, descriptionLabel, startTimeLabel, endTimeLabel].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            stateBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stateBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stateBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stateBar.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/10),

            titleLabel.leadingAnchor.constraint(equalTo: stateBar.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: startTimeLabel.leadingAnchor, constant: -5),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: stateBar.trailingAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            descriptionLabel.trailingAnchor.constraint(equalTo: endTimeLabel.leadingAnchor, constant: -5),

            startTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            startTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            startTimeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/10),

            endTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            endTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 10),
            endTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            endTimeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/10),
        ])
    }
}

fileprivate extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
