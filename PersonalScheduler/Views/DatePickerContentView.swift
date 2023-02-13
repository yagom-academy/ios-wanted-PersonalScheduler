//
//  DatePickerContentView.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit

final class DatePickerContentView: UIView, UIContentView {
    private let datePicker = UIDatePicker()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureDatePicker()
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addAction(
            UIAction(
                handler: { [weak self] _ in
                    guard let self,
                          let configuration = self.configuration as? DatePickerContentView.Configuration else { return }
                    configuration.onChange?(self.datePicker.date)
                }
            ),
            for: .valueChanged)
    }

    private func configureHierarchy() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        addSubview(datePicker)

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? DatePickerContentView.Configuration else { return }
        datePicker.date = configuration.date
    }
}

extension DatePickerContentView {
    struct Configuration: UIContentConfiguration {
        var date = Date()
        var onChange: ((Date) -> Void)?

        func makeContentView() -> UIView & UIContentView {
            return DatePickerContentView(self)
        }

        func updated(for state: UIConfigurationState) -> DatePickerContentView.Configuration {
            return self
        }
    }
}
