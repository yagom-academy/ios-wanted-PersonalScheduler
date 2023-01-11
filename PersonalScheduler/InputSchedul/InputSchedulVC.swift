//
//  InputSchedulVC.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit

class InputSchedulVC: BaseVC {
    // MARK: - View
    private let inputScheduleV = InputSchedulV()
    
    override func loadView() {
        self.view = inputScheduleV
    }
    
    var viewType: InputViewType = .add {
        didSet {
            switch viewType {
            case .add:
                setTitle(title: "일정 추가")
            case .edit(schedule: let schedule):
                setTitle(title: "일정 수정")
                self.inputScheduleV.editViewSetting(schedule: schedule)
            }
        }
    }
    // MARK: - ViewModel
    private let viewModel = InputSchedulVM()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextField()
        addButtonAction()
    }
}
// MARK: - Configure UI
extension InputSchedulVC {
    private func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: inputScheduleV.saveButton)
    }
    
    private func configureTextField() {
        inputScheduleV.titleTextField.delegate = self
        inputScheduleV.contentTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
// MARK: - ButtonAction
extension InputSchedulVC {
    private func addButtonAction() {
        self.inputScheduleV.titleTextField.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        self.inputScheduleV.saveButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    @objc private func didTapCancelButton() {
        inputScheduleV.titleTextField.text = nil
        inputScheduleV.titleTextField.isFocus = false
        inputScheduleV.titleTextField.endEditing(true)
    }
    
    @objc private func didTapAddButton() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-d_HH:mm:ss"
        let startDate = dateFormatter.string(from: self.inputScheduleV.startDatePicker.date)
        let endDate = dateFormatter.string(from: self.inputScheduleV.endDatePicker.date)
        let schedule = Schedule(title: self.inputScheduleV.titleTextField.text!,
                                startDate: startDate,
                                endDate: endDate,
                                content: self.inputScheduleV.contentTextField.text!)
        
        viewModel.input.addButtonTrigger.value = schedule
    }
}
// MARK: - TextFieldDelegate
extension InputSchedulVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !textField.text!.isEmpty {
            inputScheduleV.titleTextField.isHiddenCancelButton = false
        }
        inputScheduleV.titleTextField.isFocus = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 20 else { return false }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.inputScheduleV.setTitleLengthLabel(length: textField.text!.count)
        if textField.text!.count > 0 {
            inputScheduleV.titleTextField.isHiddenCancelButton = false
        } else {
            inputScheduleV.titleTextField.isHiddenCancelButton = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isTextEmpty = !textField.text!.isEmpty
        inputScheduleV.titleTextField.isFocus = isTextEmpty
        inputScheduleV.titleTextField.isHiddenCancelButton = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
    }
}
// MARK: - TextViewDelegate
extension InputSchedulVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.inputScheduleV.contentTextField.isFocus = true
        if textView.text == ContentTextField.placeHolderText {
            self.inputScheduleV.contentTextField.text = nil
            self.inputScheduleV.contentTextField.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.inputScheduleV.setContentLengthLabel(length: textView.text.count)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.inputScheduleV.contentTextField.isFocus = false
            self.inputScheduleV.contentTextField.text = ContentTextField.placeHolderText
            self.inputScheduleV.contentTextField.textColor = ContentTextField.placeHolderTextColor
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let char = text.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textView.text!.count < 500 else { return false }
        
        return true
    }
}
