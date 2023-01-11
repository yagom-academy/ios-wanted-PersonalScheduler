//
//  UIViewController+extension.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/11.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showDatePickerAlert(_ date: Date, handler: ((Date) -> Void)?) {
        let datePicker = createDatePicker(date)
        let dateChooserAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubviews(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateChooserAlert.view.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: dateChooserAlert.view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: dateChooserAlert.view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: dateChooserAlert.view.bottomAnchor, constant: -60)
        ])
        dateChooserAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { _ in
            handler?(datePicker.date)
        }))
        present(dateChooserAlert, animated: true, completion: nil)
    }
    
    func createDatePicker(_ date: Date) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.minuteInterval = 5
        datePicker.date = date
        return datePicker
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
