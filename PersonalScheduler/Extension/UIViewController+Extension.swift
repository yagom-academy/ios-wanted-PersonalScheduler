//
//  UIViewController+Extension.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/11.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "확인", style: .destructive))
        self.present(alert, animated: true)
    }
}
