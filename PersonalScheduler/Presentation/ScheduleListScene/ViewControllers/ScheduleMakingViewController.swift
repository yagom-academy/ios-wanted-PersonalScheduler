//
//  ScheduleMakingViewController.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import UIKit

final class ScheduleMakingViewController: UIViewController {

    private let viewModel: ScheduleMakingViewModel

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = .zero
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1
        button.layer.cornerRadius = 25

        button.addAction(UIAction { _ in
            self.viewModel.saveScheduleButtonTapped(
                title: self.titleView.textView.text, description: self.descriptionView.textView.text,
                startDate: self.timerSettingView.startTime, endDate: self.timerSettingView.endTime)
        }, for: .touchUpInside)
        return button
    }()

    private let titleView = ImageTextView(image: UIImage(systemName: "note.text"), placeholder: "제목")
    private let descriptionView = ImageTextView(image: UIImage(systemName: "text.bubble"),
                                                placeholder: "내용")
    private let timerSettingView = TimerSettingView()

    init(viewModel: ScheduleMakingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        layout()
    }

    private func bind() {
        viewModel.dismiss = { [weak self] in
            self?.dismiss(animated: true)
        }

        viewModel.showAlert = { [weak self] alert in
            self?.present(alert, animated: true)
        }
    }

    private func layout() {
        [scrollView, saveButton].forEach { view.addSubview($0) }
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor)
        ])

        [titleView, descriptionView, timerSettingView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
}
