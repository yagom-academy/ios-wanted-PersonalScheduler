//
//  ScheduleListCell.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/08.
//

import UIKit

final class ScheduleListCell: UITableViewCell {

    // MARK: - Property
    static let identifier = String(describing: ScheduleListViewController.self)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "헬스장가기"
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray2
        label.numberOfLines = 3
        label.text = "유산소 30분하고 근력운동"
        return label
    }()

    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ScheduleListCell {
    func configureUI() {
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor(hex: "#04CC00").cgColor

        [titleLabel, bodyLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        settingLayouts()
    }

    func settingLayouts() {
        let smallSpacing: CGFloat = 20
        titleLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        bodyLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: smallSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: smallSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -smallSpacing),

            bodyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: titleLabel.intrinsicContentSize.height + smallSpacing * 2),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: smallSpacing),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -smallSpacing),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -smallSpacing)
        ])
    }
}
