//
//  NavigationTitleView.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

final class NavigationTitleView: UIStackView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 102, height: 22)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(for: .body, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
            font: .preferredFont(for: .subheadline, weight: .semibold),
            scale: .medium
        )
        button.setImage(UIImage(systemName: "chevron.down")?.withConfiguration(config), for: .normal)
        button.tintColor = .label
        button.isUserInteractionEnabled = false
        return button
    }()
    
    convenience init(_ title: String) {
        self.init(frame: .zero)
        configure()
        titleLabel.text = title
    }
    
    private func configure() {
        axis = .horizontal
        alignment = .center
        distribution = .fill
        spacing = .zero
        addArrangedSubviews(titleLabel, arrowButton)
    }
    
}
