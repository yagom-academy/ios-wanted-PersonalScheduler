//
//  AlerManager.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/12.
//

import UIKit

final class AlertManager {
    static let shared = AlertManager()
    private init() { }

    func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        return alert
    }
}
