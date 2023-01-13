//
//  DateView.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

final class DateView: UIStackView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 28, height: 48)
    }
    
    convenience init() {
        self.init(frame: .zero)
        configure()
    }
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(for: .body, weight: .semibold)
        return label
    }()
    
    private lazy var ellipseView: UIView = {
        let view = UIView()
        view.backgroundColor = .psSecondaryBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 28 / 2
        view.widthAnchor.constraint(equalToConstant: 28).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        view.addSubviews(dayLabel)
        dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(for: .body, weight: .semibold)
        return label
    }()
    
}

extension DateView {
 
    func setUp(_ date: Date) {
        monthLabel.text = date.toString(.week)
        dayLabel.text = date.toString(.day)
    }
    
    func highlight() {
        dayLabel.textColor = .systemBackground
        ellipseView.backgroundColor = .psToday
    }
    
    func reset() {
        monthLabel.text = nil
        dayLabel.text = nil
        dayLabel.textColor = .label
        ellipseView.backgroundColor = .psSecondaryBackground
    }
    
}

private extension DateView {
    
    func configure() {
        axis = .vertical
        alignment = .center
        distribution = .fill
        spacing = .zero
        addArrangedSubviews(monthLabel, ellipseView)
    }
}
