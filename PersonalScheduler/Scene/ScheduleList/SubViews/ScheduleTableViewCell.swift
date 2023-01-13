//
//  ScheduleTableViewCell.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {

    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    private let cellStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = ""
        contentLabel.text = ""
        timeLabel.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubViews()
    }
    
    private func addSubViews() {
        
        self.addSubview(cellStack)
        
        cellStack.addArrangedSubview(titleLabel)
        
        cellStack.addArrangedSubview(timeLabel)
        cellStack.addArrangedSubview(contentLabel)

        NSLayoutConstraint.activate([
            cellStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                 constant: 20),
            cellStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 40),
            cellStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -40),
            cellStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -20),
            contentLabel.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    public func configure(information: ScheduleInfo) {
        titleLabel.text = information.title
        timeLabel.text = information.time.convertToString()
        contentLabel.text = information.content
    }

}
