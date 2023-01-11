//
//  CalendarCollectionViewCell.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: CalendarCollectionViewCell.self)

    override var isSelected: Bool {
        didSet {
            backgroundColorView.layer.cornerRadius = backgroundColorView.frame.height / 2
            if isSelected {
                backgroundColorView.backgroundColor = .systemBlue
                numberLabel.textColor = .white
            } else {
                backgroundColorView.backgroundColor = .white
                numberLabel.textColor = .black
            }
        }
    }

    private let backgroundColorView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
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
        contentView.addSubview(backgroundColorView)
        backgroundColorView.addSubview(numberLabel)

        NSLayoutConstraint.activate([
            backgroundColorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundColorView.widthAnchor.constraint(equalTo: backgroundColorView.heightAnchor),
            backgroundColorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            numberLabel.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 5),
            numberLabel.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -5),
            numberLabel.widthAnchor.constraint(equalTo: numberLabel.heightAnchor),
            numberLabel.centerXAnchor.constraint(equalTo: backgroundColorView.centerXAnchor)
        ])
    }

    private func setUpContentViewLayer() {
//        layer.cornerRadius =
    }
}
