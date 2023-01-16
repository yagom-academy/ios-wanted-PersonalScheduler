//
//  AddViewController.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/12.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private enum Constant {
        static var textFieldPlaceHolder = "내용을 입력해주세요."
    }
    
    static func instance(mode: DetailMode, userId: String, schedule: Schedule?) -> DetailViewController {
        let viewModel = DetailViewModel(mode: mode, schedule: schedule, userId: userId)
        let viewController = DetailViewController(viewModel: viewModel)
        return viewController
    }
    
    private var viewModel: DetailViewModelAble
    private lazy var forKeyboardConstraint = contentsTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10)
    var delegate: ListViewDelegate?
    
    init(viewModel: DetailViewModelAble) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        setUp()
        bind()
    }
    
    private lazy var overlay: UIView = {
        let view = UIView(frame: view.frame)
        view.backgroundColor = .white
        view.alpha = 0.8
        return view
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.font = .preferredFont(forTextStyle: .title1)
        textField.placeholder = "제목"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.date = Date()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .white
        return datePicker
    }()
    
    private lazy var contentsTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.font = .preferredFont(forTextStyle: .body)
        textView.text = Constant.textFieldPlaceHolder
        textView.delegate = self
        return textView
    }()
    
    private lazy var cancleButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("취소", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(cancleButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(okButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func cancleButtonClicked(_: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func okButtonClicked(_: UIButton) {
        let schedule = makeSchedule()
        guard viewModel.validationCheck(schedule: schedule) == true else {
            return
        }
        viewModel.save(schedule: schedule)
        delegate?.updateList()
        dismiss(animated: true)
    }
    
    private func setUp() {
        view.addSubview(overlay)
        view.addSubviews(titleTextField, datePicker, contentsTextView, okButton, cancleButton)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            contentsTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            contentsTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            contentsTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            contentsTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            okButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            okButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            okButton.topAnchor.constraint(equalTo: contentsTextView.bottomAnchor, constant: 10),
            okButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            okButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            cancleButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            cancleButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            cancleButton.topAnchor.constraint(equalTo: contentsTextView.bottomAnchor, constant: 10),
            cancleButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            cancleButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        ])
    }
    
    func bind() {
        viewModel.errorMessage.observe(on: self) { [weak self] errorMessage in
            if let message = errorMessage {
                self?.showErrorAlert(message: message)
            }
        }
        viewModel.currentSchedule.observe(on: self) { [weak self] schedule in
            guard let schedule = schedule else {
                return
            }
            self?.applySchedule(schedule: schedule)
        }
    }
    
    private func applySchedule(schedule: Schedule) {
        titleTextField.text = schedule.title ?? ""
        if let dateString = schedule.todoDate, let date = dateString.toDate {
            datePicker.date = date
        }
        contentsTextView.text = schedule.contents
    }
    
    private func makeSchedule() -> Schedule {
        switch viewModel.currentMode.value {
        case .edit:
            let userId = viewModel.userId
            let scheduleId = viewModel.currentSchedule.value?.scheduleId ?? UUID().uuidString
            let title = titleTextField.text
            let todoDate = datePicker.date.toFormattedString
            let contents = contentsTextView.text
            let model = Schedule(
                userId: userId,
                scheduleId: scheduleId,
                title: title,
                todoDate: todoDate,
                contents: contents
            )
            return model
        case .add:
            let userId = viewModel.userId
            let scheduleId = UUID().uuidString
            let title = titleTextField.text
            let todoDate = datePicker.date.toFormattedString
            let contents = contentsTextView.text
            let model = Schedule(
                userId: userId,
                scheduleId: scheduleId,
                title: title,
                todoDate: todoDate,
                contents: contents
            )
            return model
        }
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constant.textFieldPlaceHolder {
            textView.text = nil
        }
        datePicker.isHidden = true
        self.view.frame.origin.y -= self.view.frame.height / 2
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        datePicker.isHidden = false
        self.view.frame.origin.y = 0
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}
