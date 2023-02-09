//
//  ListTableViewCell.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

final class ListTableViewCell: UITableViewCell {

    // MARK: Identifier
    
    static let identifier = "ListTableViewCell"
    
    // MARK: Private Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.numberOfLines = 1
        label.textColor = .systemGray3
        return label
    }()
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.numberOfLines = 1
        label.textColor = .systemGray3
        return label
    }()
    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 15
        return stackView
    }()
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        stackView.spacing = 3
        return stackView
    }()
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal Methods
    
    func configureLabelText(schedule: Schedule) {
        titleLabel.text = schedule.title
        bodyLabel.text = schedule.body
        startDateLabel.text = "시작일자 : " + schedule.startDate + " " + schedule.startTime
        endDateLabel.text = "종료일자 : " + schedule.endDate + " " + schedule.endTime
    }
    
    // MARK: Private Methods
    
    private func setUpStackView() {
        dateStackView.addArrangedSubview(startDateLabel)
        dateStackView.addArrangedSubview(endDateLabel)
        
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(bodyLabel)
        totalStackView.addArrangedSubview(dateStackView)
    }
    
    private func configureLayout() {
        setUpStackView()
        
        contentView.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            startDateLabel.widthAnchor.constraint(equalTo: totalStackView.widthAnchor, multiplier: 0.45),
            
            totalStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: contentView.frame.width * 0.05
            ),
            totalStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: contentView.frame.width * 0.05
            ),
            totalStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: contentView.frame.height * 0.3
            ),
            totalStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -(contentView.frame.height * 0.3)
            )
        ])
    }
}
