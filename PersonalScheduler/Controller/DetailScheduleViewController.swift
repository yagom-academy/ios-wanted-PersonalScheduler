//
//  DetailScheduleViewController.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/08.
//

import UIKit

final class DetailScheduleViewController: UIViewController {

    // MARK: - Property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        return textField
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()

    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        return textView
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
}

// MARK: - UIConfiguration
private extension DetailScheduleViewController {
    func configureUI() {
        [titleLabel, titleTextField, bodyLabel, bodyTextView, datePicker].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        settingLayouts()
    }

    func settingLayouts() {
        let safeArea = view.safeAreaLayoutGuide
        let smallSpacing: CGFloat = 20

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: smallSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: smallSpacing),

            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: smallSpacing),

            bodyLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: smallSpacing),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: smallSpacing),

            bodyTextView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            bodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: smallSpacing),
            bodyTextView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.25),

            datePicker.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: smallSpacing),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: smallSpacing),
            datePicker.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.25)
        ])
    }
}
