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
        label.text = "제목"
        return label
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
        return textField
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "내용"
        return label
    }()

    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 10
        return textView
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()

    var mode: DetailScheduleMode = .create

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        view.backgroundColor = .systemBackground
    }
}

// MARK: - Objc Method
private extension DetailScheduleViewController {
    @objc func touchUpCreateButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc func touchUpUpdateButton() {
        navigationController?.popViewController(animated: true)
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
        settingNavigationBar()
    }

    func settingLayouts() {
        let safeArea = view.safeAreaLayoutGuide
        let bitSpacing:CGFloat = 8
        let smallSpacing: CGFloat = 20

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: smallSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -smallSpacing),

            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: bitSpacing),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -smallSpacing),
            titleTextField.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1.5),

            bodyLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: smallSpacing),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -smallSpacing),

            bodyTextView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: bitSpacing),
            bodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            bodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -smallSpacing),
            bodyTextView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.25),

            datePicker.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: smallSpacing),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallSpacing),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -smallSpacing),
            datePicker.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.25)
        ])
    }

    func settingNavigationBar() {
        switch mode {
        case .create:
            navigationItem.title = "스케쥴 생성"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(touchUpCreateButton))
        case .update:
            navigationItem.title = "스케쥴 수정"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(touchUpUpdateButton))
        }
    }
}
