//
//  ScheduleTableViewCell.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/10.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let checkingImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.square"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIConstraint
extension ScheduleTableViewCell {
    private func setupView() {
        [dateLabel, titleLabel, contentLabel].forEach(contentStackView.addArrangedSubview(_:))
        [contentStackView, checkingImageView].forEach(totalStackView.addArrangedSubview(_:))
        contentView.addSubview(totalStackView)
    }
    
    private func setupConstraint() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(
                equalTo: safeArea.topAnchor, constant: 10
            ),
            totalStackView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor, constant: 10
            ),
            totalStackView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor, constant: -10
            ),
            totalStackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor, constant: -10
            )
        ])
    }
}

extension ScheduleTableViewCell:Identifiable { }
