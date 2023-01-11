//
//  CalendarCollectionViewCell.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: CalendarCollectionViewCell.self)

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(number: Int) {
        numberLabel.text = String(number)
    }

    private func layout() {
        contentView.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
