//
//  ScheduleCell.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/08.
//

import UIKit

final class ScheduleCell: UITableViewCell {

    static var reuseIdentifier: String { String(describing: self) }

    private let dateLabel = UILabel(font: .body, textColor: .navy, textAlignment: .natural)
    private let timeLabel = UILabel(font: .body, textColor: .systemGray, textAlignment: .natural)
    private let titleLabel = UILabel(font: .title2, fontBold: true, textColor: .navy, textAlignment: .natural)
    private let detailLabel = UILabel(font: .body, textColor: .secondary, numberOfLines: 3, textAlignment: .natural)
    private let dateStackView = UIStackView(alignment: .leading, spacing: 10, margin: 10)
    private let descriptionStackView = UIStackView(axis: .vertical,
                                                   spacing: 5,
                                                   radius: 12,
                                                   backgroundColor: .primary,
                                                   margin: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    func configureCell(with viewModel: ScheduleCellViewModel) {
        dateLabel.text =  viewModel.date
        timeLabel.text = viewModel.plannedTime
        titleLabel.text = viewModel.title
        detailLabel.text = viewModel.detail
    }

    private func configureHierarchy() {
        [titleLabel, detailLabel].forEach { label in
            descriptionStackView.addArrangedSubview(label)
        }

        [dateLabel, timeLabel].forEach { view in
            dateStackView.addArrangedSubview(view)
        }

        [dateStackView, descriptionStackView].forEach { stackView in
            contentView.addSubview(stackView)
        }
    }

    private func configureLayout() {
        let margin: CGFloat = 10

        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            dateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            dateStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            dateStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),

            descriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            descriptionStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor),
            descriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            descriptionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
