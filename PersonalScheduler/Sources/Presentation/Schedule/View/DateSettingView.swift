//
//  DateSettingView.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/11.
//

import UIKit

final class DateSettingView: UIStackView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: -1, height: 20)
    }
    
    convenience init() {
        self.init(frame: .zero)
        configure()
    }
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(for: .body, weight: .light)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.font = .preferredFont(for: .body, weight: .light)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
}

extension DateSettingView {
    
    func setUp(_ date: Date) {
        dateLabel.text = date.toString(.yyyyMMddEEEE)
        timeLabel.text = date.toString(.hourMinute)
    }
    
    func highlight(_ color: UIColor) {
        dateLabel.textColor = color
        timeLabel.textColor = color
    }
    
}

private extension DateSettingView {
    
    func configure() {
        axis = .horizontal
        alignment = .fill
        distribution = .fill
        spacing = 4
        addArrangedSubviews(dateLabel, timeLabel)
    }
    
}
