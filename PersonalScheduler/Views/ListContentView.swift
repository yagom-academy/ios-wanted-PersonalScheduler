//
//  ListContentView.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit

final class ListContentView: UIView, UIContentView {
    private let titleLabel = UILabel(font: .preferredFont(forTextStyle: .title1))
    private let dateLabel = UILabel(font: .preferredFont(forTextStyle: .body))
    private let bodyLabel = UILabel(font: .preferredFont(forTextStyle: .body))
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.stackViewSpacing
        stackView.axis = .vertical
        return stackView
    }()

    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(bodyLabel)
        addSubview(stackView)

        let spacing = Constants.layoutSpacing
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing)
        ])
    }

    private func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        titleLabel.text = configuration.title
        dateLabel.text = configuration.scheduleDateText
        bodyLabel.text = configuration.body
        backgroundColor = configuration.highlightColor
    }
}

extension ListContentView {
    struct Configuration: UIContentConfiguration {
        var title: String?
        var scheduleDateText: String?
        var body: String?
        var highlightColor: UIColor = .clear

        func makeContentView() -> UIView & UIContentView {
            return ListContentView(self)
        }

        func updated(for state: UIConfigurationState) -> ListContentView.Configuration {
            return self
        }
    }
}

extension ListContentView {
    private enum Constants {
        static let stackViewSpacing = CGFloat(5)
        static let layoutSpacing = CGFloat(10)
    }
}
