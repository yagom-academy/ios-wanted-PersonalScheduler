//
//  DetailViewController.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/13.
//

import UIKit

final class DetailViewController: UIViewController {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "~"
        return label
    }()
    
    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Action
extension DetailViewController {
    @objc private func startDatePickerWheel(_ sender: UIDatePicker) -> Date {
        return sender.date
    }
    
    @objc private func endDatePickerWheel(_ sender: UIDatePicker) -> Date {
        return sender.date
    }
}


// MARK: - UIConstraint
extension DetailViewController {
    private func setupView() {
        [startDatePicker, dateLabel, endDatePicker]
            .forEach(dateStackView.addArrangedSubview(_:))
        [titleTextField, dateStackView, contentTextView]
            .forEach(detailStackView.addArrangedSubview(_:))
        view.addSubview(detailStackView)
    }
    
    private func setupPicker() {
        startDatePicker.preferredDatePickerStyle = .compact
        startDatePicker.datePickerMode = .date
        
        endDatePicker.preferredDatePickerStyle = .compact
        endDatePicker.datePickerMode = .date
        
        startDatePicker.addTarget(self, action: #selector(startDatePickerWheel), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(endDatePickerWheel), for: .valueChanged)
    }
}
