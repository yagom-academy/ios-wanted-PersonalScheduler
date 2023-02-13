//
//  TextViewContentView.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit

final class TextViewContentView: UIView, UIContentView {
    private let textView = UITextView()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureTextView()
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTextView() {
        textView.delegate = self
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
    }

    private func configureHierarchy() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight)
        ])
    }

    private func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? TextViewContentView.Configuration else { return }
        textView.text = configuration.text
    }
}

extension TextViewContentView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let configuration = configuration as? TextViewContentView.Configuration else { return }
        configuration.onChange?(textView.text)
    }
}

extension TextViewContentView {
    struct Configuration: UIContentConfiguration {
        var text = String()
        var onChange: ((String) -> Void)?

        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }

        func updated(for state: UIConfigurationState) -> TextViewContentView.Configuration {
            return self
        }
    }
}

extension TextViewContentView {
    private enum Constants {
        static let textViewHeight = CGFloat(200)
    }
}
