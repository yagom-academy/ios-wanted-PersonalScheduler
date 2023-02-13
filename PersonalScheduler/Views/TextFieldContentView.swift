//
//  TextFieldContentView.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit

final class TextFieldContentView: UIView, UIContentView {
    private let textField = UITextField()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureTextField()
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTextField() {
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        textField.addAction(
            UIAction(
                handler: { [weak self] _ in
                    guard let self,
                          let configuration = self.configuration as? TextFieldContentView.Configuration else { return }
                    configuration.onChange?(self.textField.text ?? "")
                }
            ),
            for: .editingChanged
        )
    }

    private func configureHierarchy() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)

        let spacing = Constants.layoutSpacing
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: spacing),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
    }

    private func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? TextFieldContentView.Configuration else { return }
        textField.text = configuration.text
    }
}

extension TextFieldContentView {
    struct Configuration: UIContentConfiguration {
        var text = String()
        var onChange: ((String) -> Void)?

        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }

        func updated(for state: UIConfigurationState) -> TextFieldContentView.Configuration {
            return self
        }
    }
}

extension TextFieldContentView {
    private enum Constants {
        static let layoutSpacing = CGFloat(10)
        static let textFieldHeight = CGFloat(44)
    }
}
