//
//  ScheduleContentView.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/11.
//

import UIKit

final class ScheduleContentView: UIStackView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: -1, height: 20)
    }
    
    convenience init(icon: UIImage?, contentView: UIView) {
        self.init(frame: .zero)
        self.iconImageView.image = icon
        self.contentView = contentView
        configure()
    }
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        return imageView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        return view
    }()
}

extension ScheduleContentView {
    
    func hideSeparator(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
}

private extension ScheduleContentView {
    
    private func configure() {
        axis = .horizontal
        alignment = .leading
        distribution = .fill
        spacing = 18
        addArrangedSubviews(iconImageView, contentView)
        
        addSubviews(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)
        ])
    }
    
}
