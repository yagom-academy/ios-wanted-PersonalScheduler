//
//  ScheduleCell.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/11.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

final class ScheduleCell: UITableViewCell, ReuseIdentifiable {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-Bold", size: 18)
        return label
    }()
    
    private let periodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 12)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let viewModel: ScheduleCellViewModel = ScheduleCellViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        [titleLabel, descriptionLabel, periodLabel].forEach(stackView.addArrangedSubview(_:))
        contentView.addSubview(stackView)
        
        viewModel.delegate = self
    }
    
    private func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setupCellData(from preview: SchedulePreview) {
        viewModel.checkDate(from: preview.startDate, to: preview.endDate)
        titleLabel.text = preview.title
        periodLabel.text = preview.period
        descriptionLabel.text = preview.description
    }
}

extension ScheduleCell: ScheduleCellViewModelDelegate {
    func scheduleCellViewModelDelegate(checkedResult: DateState) {
        switch checkedResult {
        case .expired:
            stackView.backgroundColor = .systemGray
        case .today:
            stackView.backgroundColor = UIColor(red: 178/255, green: 222/255, blue: 158/255, alpha: 1.0)
        case .notYet:
            stackView.backgroundColor = .systemGray6
        }
    }
}
