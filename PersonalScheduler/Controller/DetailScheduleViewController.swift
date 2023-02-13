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
    var modelID: UUID?
    weak var detailScheduleDelegate: DetailScheduleDelegate?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
}

// MARK: - UITextViewDelegate
extension DetailScheduleViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let limitedLine = 500
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= limitedLine
    }
}

// MARK: - Method
private extension DetailScheduleViewController {
    func getScheduleModel(id: UUID = UUID()) -> ScheduleModel? {
        guard let title = titleTextField.text,
              let body = bodyTextView.text,
              title != "",
              body != "" else {
            showAlert()
            return nil
        }
        let date = DateformatterManager.shared.convertDateToString(date: datePicker.date)
        let data = ScheduleModel(id: id, title: title, body: body, date: date)
        return data
    }
}

// MARK: - Objc Method
private extension DetailScheduleViewController {
    @objc func touchUpCreateButton() {
        guard let data = getScheduleModel() else { return }
        detailScheduleDelegate?.createSchedule(data: data)
        navigationController?.popViewController(animated: true)
    }

    @objc func touchUpUpdateButton() {
        guard let id = modelID,
            let data = getScheduleModel(id: id) else { return }
        detailScheduleDelegate?.updateSchedule(data: data)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIConfiguration
private extension DetailScheduleViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        [titleLabel, titleTextField, bodyLabel, bodyTextView, datePicker].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        bodyTextView.delegate = self
        settingLayouts()
        settingNavigationBar()
        settingTitleTextField()
        settingData()
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

    func settingTitleTextField() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = .always
    }

    func showAlert() {
        let alertController = UIAlertController(title: "정보를 입력해주세요", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    func settingData() {
        if mode == .update {
            guard let modelID = modelID,
                  let data = ScheduleModel.scheduleList.first(where: { scheduleModel in
                      scheduleModel.id == modelID
                  }),
                  let date = DateformatterManager.shared.convertStringToDate(dateText: data.date) else { return }
            titleTextField.text = data.title
            bodyTextView.text = data.body
            datePicker.date = date
        }
    }
}
