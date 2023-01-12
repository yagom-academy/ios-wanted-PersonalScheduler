//
//  ScheduleEditViewController.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import UIKit

enum EditType {
    case add, update
}

final class ScheduleEditViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: ScheduleEditViewModel
    let editType: EditType
    
    // MARK: - Views
    
    private let scrollView = UIScrollView()
    public let contentView = UIView()
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "일정"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        return textField
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "일시"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateTimePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko-KR")
        return datePicker
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textView.textColor = .black
        textView.backgroundColor = .systemGray5
        textView.layer.cornerRadius = 12
        return textView
    }()
    
    // MARK: - Life Cycle
    
    init(editType: EditType) {
        self.viewModel = ScheduleEditViewModel(nil)
        self.editType = editType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    override func setupView() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStack)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, titleTextField, timeLabel, dateTimePicker, contentLabel, contentTextView].forEach {
            contentStack.addArrangedSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            contentTextView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
    }
    
    override func bindViewModel() {
        self.viewModel.dismiss.subscribe { [weak self] isTrue in
            guard let isTrue = isTrue else { return }
            if isTrue { self?.pop() }
        }
    }
}

// MARK: Navigation

extension ScheduleEditViewController {
    
    private func configureNavigationBar() {
        let saveButton = UIBarButtonItem(title: "저장",
                                            style: .done,
                                            target: self,
                                            action: #selector(saveSchedule))
        
        let cancelButton = UIBarButtonItem(title: "취소",
                                            style: .done,
                                            target: self,
                                            action: #selector(cancel))

        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "제리네 일정"
    }
    
    @objc private func saveSchedule() {
        viewModel.addSchedule(title: titleTextField.text ?? "", time: dateTimePicker.date, content: contentTextView.text)
    }
    
    @objc private func cancel() {
        self.pop()
    }
    
    private func pop() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension ScheduleEditViewController {

}
