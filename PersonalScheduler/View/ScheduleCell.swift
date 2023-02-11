//
//  ScheduleCell.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/08.
//

import UIKit

protocol ScheduleCellDelegate {

    func touchedUpCheckButton(of viewModel: ScheduleCellViewModel)
}

final class ScheduleCell: UITableViewCell {

    static var reuseIdentifier: String { String(describing: self) }

    var delegate: ScheduleCellDelegate?

    private let dateLabel = UILabel(font: .body, textColor: .navy, textAlignment: .natural)
    private let timeLabel = UILabel(font: .body, textColor: .systemGray, textAlignment: .natural)
    private let titleLabel = UILabel(font: .title2, fontBold: true, textColor: .navy, textAlignment: .natural)
    private let descriptionLabel = UILabel(font: .body, textColor: .secondary, numberOfLines: 3, textAlignment: .natural)
    private let dateStackView = UIStackView(alignment: .leading, spacing: 10, margin: 10)
    private let descriptionStackView = UIStackView(axis: .vertical, spacing: 5, backgroundColor: .primary)
    private let totalStackView = UIStackView(alignment: .center,
                                             spacing: 10,
                                             radius: 12,
                                             backgroundColor: .primary,
                                             margin: 10)

    private lazy var checkButton: UIButton = {
        let button: UIButton = UIButton(type: .infoLight)
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .semibold, scale: .medium)
        let checkImage = UIImage(systemName: "checkmark.circle", withConfiguration: imageConfiguration)?
            .withTintColor(.secondary ?? .systemBlue, renderingMode:  .alwaysOriginal)
        button.setImage(checkImage, for: .normal)
        button.backgroundColor = .primary
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let descriptionView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 12
        view.backgroundColor = .primary
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureHierarchy()
        configureLayout()
    }
    
    func configureCell(with viewModel: ScheduleCellViewModel) {
        dateLabel.text =  viewModel.date
        timeLabel.text = viewModel.plannedTime
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }

    func addActionToCheckButton(of viewModel: ScheduleCellViewModel) {
        let action = UIAction { [weak self] _ in
            self?.delegate?.touchedUpCheckButton(of: viewModel)
        }

        checkButton.addAction(action, for: .touchUpInside)
    }

    private func configureHierarchy() {
        [dateLabel, timeLabel].forEach { view in
            dateStackView.addArrangedSubview(view)
        }

        [titleLabel, descriptionLabel].forEach { label in
            descriptionStackView.addArrangedSubview(label)
        }

        [checkButton, descriptionStackView].forEach { stackView in
            totalStackView.addArrangedSubview(stackView)
        }

        [dateStackView, totalStackView].forEach { stackView in
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

            descriptionStackView.widthAnchor.constraint(equalTo: totalStackView.widthAnchor, multiplier: 0.8),
            totalStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            totalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
