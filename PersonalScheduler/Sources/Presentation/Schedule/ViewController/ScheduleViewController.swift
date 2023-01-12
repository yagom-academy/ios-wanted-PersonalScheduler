//
//  ScheduleViewController.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit
import Combine

class ScheduleViewController: UIViewController {
    
    enum ViewType {
        case create
        case edit
    }
    
    private let type: ViewType
    public weak var coordinator: ScheduleCoordinatorInterface?
    
    private let viewModel: ScheduleViewModel
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        viewModel.input.viewDidLoad()
    }
    
    init(viewModel: ScheduleViewModel, coordinator: ScheduleCoordinatorInterface, type: ViewType) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.type = type
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubviews(backgroundStackView)
        NSLayoutConstraint.activate([
            backgroundStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            backgroundStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            backgroundStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            backgroundStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            backgroundStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        return scrollView
    }()
    
    private lazy var backgroundStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 40.3)
        stackView.backgroundColor = .clear
        stackView.addArrangedSubviews()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 20,
            trailing: 20
        )
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        stackView.addGestureRecognizer(tap)
        let titleView = ScheduleContentView(
            icon: UIImage(systemName: "circle.fill")?.withTintColor(.psToday).withRenderingMode(.alwaysOriginal),
            contentView: titleTextField
        )
        let startDateView = ScheduleContentView(
            icon: UIImage(systemName: "clock")?.withTintColor(.label).withRenderingMode(.alwaysOriginal),
            contentView: startDateSettingView
        )
        let endDateView = ScheduleContentView(
            icon: nil,
            contentView: endDateSettingView
        )
        let descriptionView = ScheduleContentView(
            icon: UIImage(systemName: "highlighter")?.withTintColor(.label).withRenderingMode(.alwaysOriginal),
            contentView: descriptionTextView
        )
        descriptionView.hideSeparator(true)
        stackView.addArrangedSubviews(titleView, startDateView, endDateView, descriptionView)
        return stackView
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 76).isActive = true
        textField.placeholder = "일정 제목"
        textField.tintColor = .label
        textField.font = .preferredFont(for: .body, weight: .regular)
        return textField
    }()
    
    private lazy var startDateSettingView: DateSettingView = {
        let view = DateSettingView()
        view.setUp(Date().nearestHour())
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTapStartDate(_:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var endDateSettingView: DateSettingView = {
        let view = DateSettingView()
        view.setUp(Date().nearestHour().plusHour(1))
        view.highlight(.systemRed)
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTapEndDate(_:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private let descriptionPlaceHolder = "일정 내용 작성하기 (500자 제한)"
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.heightAnchor.constraint(equalToConstant: 420).isActive = true
        textView.backgroundColor = .psBackground
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textColor = .darkGray
        textView.tintColor = .label
        textView.text = descriptionPlaceHolder
        textView.delegate = self
        textView.contentInset = .zero
        textView.textContainerInset = .zero
        return textView
    }()
    
    private lazy var activityIndicator: LoadingView = {
        let activityIndicator = LoadingView(backgroundColor: .clear, alpha: 1)
        return activityIndicator
    }()
    
}

private extension ScheduleViewController {
    
    func bind() {
        viewModel.output.title
            .compactMap { $0 }
            .filter { $0.isEmpty == false }
            .sinkOnMainThread(receiveValue: { [weak self] text in
                self?.titleTextField.text = text
            }).store(in: &cancellables)
        
        viewModel.output.startDate
            .sinkOnMainThread(receiveValue: { [weak self] date in
                self?.startDateSettingView.setUp(date)
            }).store(in: &cancellables)
        
        viewModel.output.endDate
            .sinkOnMainThread(receiveValue: { [weak self] date in
                self?.endDateSettingView.setUp(date)
            }).store(in: &cancellables)
        
        viewModel.output.description
            .compactMap { $0 }
            .filter { $0.isEmpty == false }
            .sinkOnMainThread(receiveValue: { [weak self] text in
                self?.descriptionTextView.text = text
                self?.descriptionTextView.textColor = .label
            }).store(in: &cancellables)
        
        viewModel.output.isCompleted
            .filter { $0 == true }
            .sinkOnMainThread(receiveValue: { [weak self] _ in
                self?.coordinator?.dismiss()
            }).store(in: &cancellables)
        
        viewModel.output.isLoading
            .sinkOnMainThread(receiveValue: { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }).store(in: &cancellables)
        
        viewModel.output.errorMessage
            .compactMap { $0 }
            .sinkOnMainThread(receiveValue: { [weak self] message in
                self?.showAlert(message: message)
            }).store(in: &cancellables)
        
        viewModel.output.isValidDate
            .sinkOnMainThread(receiveValue: { [weak self] isValidDate in
                self?.endDateSettingView.highlight(isValidDate ? .label : .systemRed)
                self?.navigationItem.rightBarButtonItem?.isEnabled = isValidDate
            }).store(in: &cancellables)
    }
    
    func setUp() {
        setUpLayout()
        setUpNavigationBar()
    }
    
    func setUpLayout() {
        view.backgroundColor = .psBackground
        view.addSubviews(scrollView, activityIndicator)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.widthAnchor.constraint(equalTo: view.widthAnchor),
            activityIndicator.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
 
    func setUpNavigationBar() {
        let saveButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTapSaveButton(_:)))
        let cancelButton = UIBarButtonItem(
            image: UIImage(systemName: type == .create ? "xmark" : "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(didTapCancelButton(_:))
        )
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.addCustomBottomLine(color: .systemGray4, height: 0.3)
    }
    
    @objc func didTapSaveButton(_ sender: UIBarButtonItem) {
        let description = descriptionTextView.text ?? ""
        viewModel.input.didTapSaveButton(
            title: titleTextField.text ?? "",
            description: description == descriptionPlaceHolder ? "" : description
        )
        
    }
    
    @objc func didTapCancelButton(_ sender: UIBarButtonItem) {
        coordinator?.dismiss()
    }
    
    @objc func didTapStartDate(_ gesture: UITapGestureRecognizer) {
        showDatePickerAlert(viewModel.output.currentStartData) { [weak self] date in
            self?.viewModel.input.didChangeStartDate(date)
        }
    }
    
    @objc func didTapEndDate(_ gesture: UITapGestureRecognizer) {
        showDatePickerAlert(viewModel.output.currentEndData) { [weak self] date in
            self?.viewModel.input.didChangeEndDate(date)
        }
    }
    
}

extension ScheduleViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == descriptionPlaceHolder {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text.count - range.length + text.count
        let koreanMaxCount = 500 + 1
        if newLength > koreanMaxCount {
            let overflow = newLength - koreanMaxCount
            if text.count < overflow {
                return true
            }
            let index = text.index(text.endIndex, offsetBy: Int(-overflow))
            let newText = text[..<index]
            guard let startPosition = textView.position(from: textView.beginningOfDocument, offset: range.location) else {
                return false
            }
            guard let endPosition = textView.position(from: textView.beginningOfDocument, offset: NSMaxRange(range)) else {
                return false
            }
            guard let textRange = textView.textRange(from: startPosition, to: endPosition) else {
                return false
            }
            textView.replace(textRange, withText: String(newText))
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = descriptionPlaceHolder
            textView.textColor = .darkGray
        }
        if textView.text.count > 500 {
            textView.text.removeLast()
        }
    }
}
