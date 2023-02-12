//
//  DetailViewController.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/13.
//

import UIKit

final class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
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
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupNavigationBar()
        setupBind()
        setupView()
        setupPicker()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Binding
extension DetailViewController {
    private func setupBind() {
        viewModel.bindTitle { [weak self] title in
            self?.titleTextField.text = title
        }
        
        viewModel.bindContent { [weak self] content in
            self?.contentTextView.text = content
        }
        
        viewModel.bindStartDate { [weak self] date in
            self?.startDatePicker.setDate(date, animated: true)
        }
        
        viewModel.bindEndDate { [weak self] date in
            self?.endDatePicker.setDate(date, animated: true)
        }
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
    private func setupNavigationBar() {
        title = viewModel.mode.rawValue
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
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
    
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            detailStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            detailStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
