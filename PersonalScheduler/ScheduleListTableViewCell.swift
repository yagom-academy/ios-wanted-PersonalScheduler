//
//  ScheduleListTableViewCell.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/10.
//

import UIKit

final class ScheduleListTableViewCell: UITableViewCell {
    static let identifier = "ScheduleListTableViewCell"
    
    private let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7264262438, green: 0.9996786714, blue: 0.5089451671, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell.circle")
        imageView.tintColor = .systemOrange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.font = .boldSystemFont(ofSize: label.font.pointSize)
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scheduleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubView()
        setupConstraint()
    }
    
    private func addSubView() {
        scheduleStackView.addArrangedSubview(titleLabel)
        scheduleStackView.addArrangedSubview(contentLabel)
        
        entireStackView.addArrangedSubview(highlightView)
        entireStackView.addArrangedSubview(bellImageView)
        entireStackView.addArrangedSubview(scheduleStackView)
        
        self.contentView.addSubview(entireStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            entireStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            entireStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            entireStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
}
