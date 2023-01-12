//
//  ScheduleCell.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import UIKit

class ScheduleCell: UITableViewCell {
    static let cellID: String = "scheduleCell"
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "time"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "content"
        label.textColor = .black
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, startTimeLabel, contentLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ScheduleCell.cellID)
        addView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        self.addSubview(stackView)
    }
    
    private func setConstraints() {
        let layout = [
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(layout)
    }
    
    func configureCellData(schedule: Schedule, currentDate: Date) {
        self.titleLabel.text = schedule.title
//        let relpaceStartDate = schedule.startDate.replacingCharacters(in: "", with: "")
        self.startTimeLabel.text = "\(schedule.startDate) ~ \(schedule.endDate)"
        self.contentLabel.text = schedule.content
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-d_HH:mm:ss"
        let startDate = dateFormatter.date(from: schedule.startDate)!
        let endDate = dateFormatter.date(from: schedule.endDate)!
        if currentDate > startDate && currentDate < endDate {
            self.backgroundColor = .green
        } else {
            self.backgroundColor = .systemGray5
        }
    }
}
