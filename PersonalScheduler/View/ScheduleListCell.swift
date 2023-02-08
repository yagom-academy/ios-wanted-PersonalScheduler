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
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray3
        label.numberOfLines = 3
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
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(hex: "#04CC00").cgColor

        [titleLabel, bodyLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        settingLayouts()
    }

    func settingLayouts() {
        let smallSpacing: CGFloat = 20

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: smallSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: smallSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: smallSpacing),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: smallSpacing),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: smallSpacing),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: smallSpacing),
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: smallSpacing)
        ])
    }
}
