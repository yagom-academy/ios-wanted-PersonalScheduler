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
        return label
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let bodyTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        return datePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
