//
//  UIViewController+Alert.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/11.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인",
                                      style: .default))
        self.present(alert, animated: true)
    }
    
    func showAlert(_ alertType: AlertPhrase) {
        let alert = UIAlertController(title: alertType.title,
                                      message: alertType.message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인",
                                      style: .default))
        self.present(alert, animated: true)
    }
}
