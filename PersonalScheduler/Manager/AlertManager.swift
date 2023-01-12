//
//  AlertManager.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/12.
//

import Foundation
import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    func showErrorAlert(error: Error, viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        viewController.present(alert, animated: true, completion: nil)
    }
}
