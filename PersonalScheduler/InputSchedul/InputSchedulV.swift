//
//  InputSchedulV.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import UIKit

class InputSchedulV: UIView, BaseView {
    
    lazy var titleTextField: TitleTextField = {
        let textField = TitleTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHiddenCancelButton = true
        
        return textField
    }()
    
    private lazy var titleLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, titleLengthLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .trailing
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        return stackView
    }()
    
    lazy var contentTextField: ContentTextField = {
        let textView = ContentTextField()
        
        return textView
    }()
    
    private lazy var contentLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contentTextField, contentLengthLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .trailing
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubview(titleStackView)
        self.addSubview(contentStackView)
    }
    
    func setTitleLengthLabel(length: Int) {
        titleLengthLabel.text = "\(length)/20"
    }
    
    func setContentLengthLabel(length: Int) {
        contentLengthLabel.text = "\(length)/500"
    }
}
// MARK: - Constraints
extension InputSchedulV {
    func constraints() {
        let layout = [
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 48),
            titleTextField.widthAnchor.constraint(equalTo: titleStackView.widthAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contentStackView.topAnchor.constraint(equalTo: self.titleStackView.bottomAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            contentTextField.heightAnchor.constraint(equalToConstant: 144),
            contentTextField.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(layout)
    }
}
