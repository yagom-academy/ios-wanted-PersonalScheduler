//
//  RegisterViewController.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/10.
//

import UIKit

protocol RegisterViewControllerDelegate {

    func registerEvent(state: RegisterViewModel.State,
                       title: String?,
                       date: Date,
                       startTime: Date,
                       endTime: Date,
                       description : String,
                       uuid: UUID)
}

final class RegisterViewController: UIViewController {

    var delegate: RegisterViewControllerDelegate?
    private let viewModel: RegisterViewModel
    private let viewLabel = UILabel(font: .title2, fontBold: true, textColor: .navy, textAlignment: .center)
    private let titleField = UITextField(font: .title2, radius: 12)
    private let datePicker = UIDatePicker(mode: .date, style: .wheels)
    private let startLabel = UILabel(font: .title3, textColor: .black, textAlignment: .right)
    private let endLabel = UILabel(font: .title3, textColor: .black, textAlignment: .right)
    private let startTimePicker = UIDatePicker(mode: .time, style: .compact)
    private let endTimePicker = UIDatePicker(mode: .time, style: .compact)
    private let startTimeStackView = UIStackView(spacing: 10, margin: 10)
    private let endTimeStackView = UIStackView(spacing: 10, margin: 10)
    private let totalStackView = UIStackView(axis: .vertical, distribution: .fill, spacing: 10, margin: 10)

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

    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.keyboardDismissMode = .interactive
        scrollview.translatesAutoresizingMaskIntoConstraints = false

        return scrollview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        bindViewModel()
        addKeyboardNotifications()
    }

    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindViewModel() {
        viewLabel.text =  viewModel.viewTitle
        startLabel.text = viewModel.startLabelText
        endLabel.text = viewModel.endLabelText
        titleField.placeholder = viewModel.titleFieldPlaceHolder
        titleField.text = viewModel.title
        datePicker.date = viewModel.date
        startTimePicker.date = viewModel.startTime
        endTimePicker.date = viewModel.endTime
        descriptionTextView.text = viewModel.description
    }

    @objc private func touchedUpPlusButton() {
        delegate?.registerEvent(state: viewModel.state,
                                title: titleField.text,
                                date: datePicker.date,
                                startTime: startTimePicker.date,
                                endTime: endTimePicker.date,
                                description : descriptionTextView.text,
                                uuid: viewModel.uuid)
        self.dismiss(animated: true)
    }
}

//MARK: - Handling Keyboard
extension RegisterViewController {

    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setKeyboardShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setKeyboardHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc private func setKeyboardShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.height

        self.scrollView.contentInset.bottom = keyboardHeight

        if self.descriptionTextView.isFirstResponder {
            self.scrollView.contentOffset.y = keyboardHeight
        }
    }

    @objc private func setKeyboardHide(_ notification: Notification) {
        self.scrollView.contentInset.bottom = 0
    }
}

//MARK: - ViewHierarchy and Layout
extension RegisterViewController {

    private func configureHierarchy() {
        [startLabel, startTimePicker].forEach { view in
            startTimeStackView.addArrangedSubview(view)
        }

        [endLabel, endTimePicker].forEach { view in
            endTimeStackView.addArrangedSubview(view)
        }

        [titleField, datePicker, startTimeStackView, endTimeStackView, descriptionTextView].forEach { view in
            totalStackView.addArrangedSubview(view)
        }

        scrollView.addSubview(totalStackView)
        view.addSubview(scrollView)
        view.addSubview(viewLabel)
        view.addSubview(registerButton)
    }

    private func configureLayout() {
        titleField.addPadding(width: 10)
        descriptionTextView.setContentHuggingPriority(.defaultLow, for: .vertical)

        NSLayoutConstraint.activate([
            viewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            viewLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),

            registerButton.centerYAnchor.constraint(equalTo: viewLabel.centerYAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            registerButton.heightAnchor.constraint(equalTo: viewLabel.heightAnchor, multiplier: 0.5),
            registerButton.widthAnchor.constraint(equalTo: registerButton.heightAnchor),

            titleField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),

            endLabel.widthAnchor.constraint(equalTo: startLabel.widthAnchor),

            descriptionTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),

            totalStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            totalStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: viewLabel.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
