//
//  ScheduleHeaderView.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/12.
//

import UIKit

final class ScheduleHeaderView: UITableViewHeaderFooterView, ReuseIdentifiable {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureView() {
        contentView.addSubview(titleLabel)
    }
    
    private func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}
