//
//  ScheduleTableViewCell.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/10.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    private weak var delegate: DataManageable?
    
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
    
    private let checkButton: UIButton = {
        let button = UIButton()
        
        button.tintColor = .systemOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var viewModel: CellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        titleLabel.text = nil
        contentLabel.text = nil
        checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
    }
    
    func setupData(_ viewModel: CellViewModel, delegate: DataManageable) {
        self.delegate = delegate
        self.viewModel = viewModel
        
        viewModel.bindData { [weak self] schedule in
            self?.dateLabel.text = DateFormatter.removeTime(from: schedule.startDate) + "-" + DateFormatter.removeTime(from: schedule.endDate)

            self?.titleLabel.text = schedule.title
            self?.contentLabel.text = schedule.content
            if schedule.state == .complete {
                self?.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            } else {
                self?.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            }
        }
    }
}

extension ScheduleTableViewCell {
    @objc private func checkButtonTapped() {
        guard let data = viewModel?.changeState() else { return }
        delegate?.changeDataProcess(data: data)
    }
}

// MARK: - UIConstraint
extension ScheduleTableViewCell {
    private func setupView() {
        [dateLabel, titleLabel, contentLabel].forEach(contentStackView.addArrangedSubview(_:))
        [contentStackView, checkButton].forEach(totalStackView.addArrangedSubview(_:))
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
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
