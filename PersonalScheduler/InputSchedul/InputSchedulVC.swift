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
    // MARK: - ViewModel
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
        setTitle(title: "스케줄 추가")
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
    }
    
    @objc private func didTapCancelButton() {
        inputScheduleV.titleTextField.text = nil
        inputScheduleV.titleTextField.isFocus = false
        inputScheduleV.titleTextField.endEditing(true)
    }
}
// MARK: - TextFieldDelegate
extension InputSchedulVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputScheduleV.titleTextField.isFocus = false
        inputScheduleV.titleTextField.isHiddenCancelButton = true
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
        self.inputScheduleV.contentTextField.isFocus = false
        if textView.text.isEmpty {
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
