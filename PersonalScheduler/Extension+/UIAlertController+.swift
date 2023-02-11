//
//  File.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/11.
//

import UIKit

extension UIAlertController {

    static func showError(message: String?, target: UIViewController) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)

        alert.addAction(OKAction)
        target.present(alert, animated: true, completion: nil)
    }
}
