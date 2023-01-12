//
//  ScheduleEnrollViewController.swift
//  PersonalScheduler
//
//  Created by bard on 2023/01/13.
//

import UIKit

final class ScheduleEnrollViewController: UIViewController {
    
    // MARK: Properties
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    private let enrollButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("등록", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .preferredFont(forTextStyle: .title1)
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.placeholder = "제목"
        return textField
    }()
    
    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textContainerInset = UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16
        )
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 20
        textView.layer.masksToBounds = true
        textView.text = "내용"
        textView.textColor = .lightGray
        textView.delegate = self
        
        return textView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        view.backgroundColor = .systemBackground
        modalPresentationStyle = .fullScreen
        setupSubviews()
        setupConstraints()
        setupCancelButton()
        setupEnrollButton()
    }
    
    private func setupSubviews() {
        [cancelButton, titleTextField, bodyTextView, enrollButton]
            .forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        setupCancelButtonConstraints()
        setupTitleTextFieldConstraints()
        setupBodyTextFieldConstraints()
        setupEnrollButtonConstraints()
    }
    
    private func setupCancelButtonConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(
                equalTo: enrollButton.topAnchor
            ),
            cancelButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 28
            )
        ])
    }
    
    private func setupTitleTextFieldConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(
                equalTo: enrollButton.bottomAnchor,
                constant: 40
            ),
            titleTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 28
            ),
            titleTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -28
            )
        ])
    }
    
    private func setupBodyTextFieldConstraints() {
        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(
                equalTo: titleTextField.bottomAnchor,
                constant: 40
            ),
            bodyTextView.leadingAnchor.constraint(
                equalTo: titleTextField.leadingAnchor
            ),
            bodyTextView.trailingAnchor.constraint(
                equalTo: titleTextField.trailingAnchor
            ),
            bodyTextView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -40
            )
        ])
    }
    
    private func setupEnrollButtonConstraints() {
        NSLayoutConstraint.activate([
            enrollButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            enrollButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            )
        ])
    }
    
    private func setupCancelButton() {
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonDidTap),
            for: .touchUpInside
        )
    }
    
    private func setupEnrollButton() {
        enrollButton.addTarget(
            self,
            action: #selector(enrollButtonDidTap),
            for: .touchUpInside
        )
    }
    
    @objc
    private func cancelButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc
    private func enrollButtonDidTap() {
        dismiss(animated: true)
    }
}

extension ScheduleEnrollViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == "내용" {
               textView.text = nil
               textView.textColor = .black
           }
       }

       func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
               textView.text = "내용"
               textView.textColor = .lightGray
           }
       }

       func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
       ) -> Bool {
           let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
           guard let oldString = textView.text,
                    let newRange = Range(range, in: oldString) else {
               return true
           }
           let newString = oldString.replacingCharacters(
            in: newRange,
            with: inputString
           ).trimmingCharacters(in: .whitespacesAndNewlines)

           let characterCount = newString.count
           guard characterCount <= 700 else { return false }

           return true
       }
}
