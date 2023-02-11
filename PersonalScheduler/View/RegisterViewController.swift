//
//  RegisterViewController.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/10.
//

import UIKit

final class RegisterViewController: UIViewController {

    private let viewLabel = UILabel(text: "Add new event",
                            font: .title2,
                            fontBold: true,
                            textColor: .navy,
                            textAlignment: .center)

    private let descriptionTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.backgroundColor = .systemGray5
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.layer.cornerRadius = 12
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .custom)
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let plusImage =  UIImage(systemName: "pencil.line", withConfiguration: imageConfiguration)?
            .withTintColor(.tertiary ?? .white, renderingMode: .alwaysOriginal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .secondary
        button.setImage(plusImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchedUpPlusButton), for: .touchUpInside)

        return button
    }()

    @objc private func touchedUpPlusButton() {
        print("펜슬버튼 클릭")
    }

    private let titleField = UITextField(font: .title2, placeholder: "title", radius: 12)
    private let startLabel = UILabel(text: "Start", font: .title3, textColor: .black, textAlignment: .right)
    private let endLabel = UILabel(text: "End", font: .title3, textColor: .black, textAlignment: .right)
    private let startTimePicker = UIDatePicker(mode: .time, style: .compact)
    private let endTimePicker = UIDatePicker(mode: .time, style: .compact)
    private let datePicker = UIDatePicker(mode: .date, style: .wheels)
    private let startTimeStackView = UIStackView(spacing: 10, margin: 10)
    private let endTimeStackView = UIStackView(spacing: 10, margin: 10)
    private let totalStackView = UIStackView(axis: .vertical, distribution: .fill, spacing: 10, margin: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
    }

    private func configureHierarchy() {
        [startLabel, startTimePicker].forEach { view in
            startTimeStackView.addArrangedSubview(view)
        }
        [endLabel, endTimePicker].forEach { view in
            endTimeStackView.addArrangedSubview(view)
        }
        [viewLabel, titleField, startTimeStackView, endTimeStackView, datePicker, descriptionTextView].forEach { view in
            totalStackView.addArrangedSubview(view)
        }

        view.addSubview(totalStackView)
        view.addSubview(registerButton)
    }

    private func configureLayout() {
        titleField.addPadding(width: 10)
        descriptionTextView.setContentHuggingPriority(.defaultLow, for: .vertical)

        NSLayoutConstraint.activate([
            registerButton.centerYAnchor.constraint(equalTo: viewLabel.centerYAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            registerButton.heightAnchor.constraint(equalTo: viewLabel.heightAnchor, multiplier: 0.5),
            registerButton.widthAnchor.constraint(equalTo: registerButton.heightAnchor),

            viewLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            titleField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            endLabel.widthAnchor.constraint(equalTo: startLabel.widthAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            totalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
