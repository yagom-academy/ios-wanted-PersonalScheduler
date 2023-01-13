//
//  ScheduleTableViewCell.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/12.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    static let identifier = "ScheduleCell"

    let startedAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    let mainBodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()

    let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        addSubViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func addSubViews() {
        self.contentView.addSubview(informationStackView)

        informationStackView.addArrangedSubview(titleLabel)
        informationStackView.addArrangedSubview(mainBodyLabel)
        informationStackView.addArrangedSubview(startedAtLabel)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            informationStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            informationStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            informationStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            informationStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
    }

    func configureCell(at indexPath: IndexPath, cellData: [ScheduleModel]) {
        titleLabel.text = cellData[indexPath.row].title
        mainBodyLabel.text = cellData[indexPath.row].mainText
        startedAtLabel.text = cellData[indexPath.row].startDate
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        mainBodyLabel.text = nil
        startedAtLabel.text = nil
    }
}
