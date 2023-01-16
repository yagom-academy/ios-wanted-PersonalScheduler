//
//  ScheduleCell.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/12.
//

import Foundation
import UIKit

class ScheduleCell: UITableViewCell {
    private let backgroundStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .leading, distribution: .fill, spacing: 4)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 6
        return stackview
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKannada-Bold", size: 15)
        label.textColor = .Red_60
        label.text = "제목: "
        return label
    }()
    
    private let titlesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKannada-Regular", size: 13)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "제목이다라라라랄ㄹ"
        return label
    }()
    
    private let bodyStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 6
        return stackview
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKannada-Bold", size: 15)
        label.textColor = .Red_60
        label.text = "내용: "
        return label
    }()
    
    private let bodysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKannada-Regular", size: 13)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "내용이다라라라랄ㄹ"
        label.numberOfLines = 2
        return label
    }()
    
    private let feelStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 6
        return stackview
    }()
    
    private let feelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKannada-Bold", size: 15)
        label.textColor = .Red_60
        label.text = "오늘 기분: "
//        label.setContentHuggingPriority(.required, for: .horizontal)
//        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let feelsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKannada-Regular", size: 13)
        label.textColor = .white
        label.text = "☺️"
        label.numberOfLines = 2
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let dateStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 6
        return stackview
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKannada-Bold", size: 15)
        label.textColor = .Red_60
//        label.setContentHuggingPriority(.required, for: .horizontal)
//        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "날짜: "
        return label
    }()
    
    private let datesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKannada-Regular", size: 13)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "2022.01.13"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = .Beige
        self.contentView.backgroundColor = .Beige
        
        contentView.addSubview(backgroundStackView)
        
        backgroundStackView.addArrangedSubviews(titleStackView, bodyStackView, feelStackView, dateStackView)
        titleStackView.addArrangedSubviews(titleLabel, titlesLabel)
        bodyStackView.addArrangedSubviews(bodyLabel, bodysLabel)
        feelStackView.addArrangedSubviews(feelLabel, feelsLabel)
        dateStackView.addArrangedSubviews(dateLabel, datesLabel)
    }
    
    func setupAutolayout() {
        NSLayoutConstraint.activate([
            backgroundStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backgroundStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            backgroundStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func transferData(schedule: Schedule) {
        titlesLabel.text = schedule.title
        bodysLabel.text = schedule.body
        datesLabel.text = schedule.startDate
    }
    
}
