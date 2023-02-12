//
//  ScheduleDetailTitleView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import UIKit
import Combine

protocol ScheduleDetailTitleDelegate: AnyObject {
    func scheduleDetailTitleView(with titleView: ScheduleDetailTitleView, title: String?)
    func scheduleDetailTitleView(didTapStartTime titleView: ScheduleDetailTitleView)
    func scheduleDetailTitleView(didTapEndTime titleView: ScheduleDetailTitleView, endTime: Date)
}

final class ScheduleDetailTitleView: NavigationBar {
    private let titleTextField: ScheduleTextField = {
        let textField = ScheduleTextField()
        textField.placeholder = "할일의 제목을 입력해주세요."
        return textField
    }()
    
    private let startDateButton = UIButton()
        .setInitState()
        .setTitleLabel(title: "시작일시")
        .setImage(imageName: "endFlag")
        .setBorder(color: UIColor(named: "textFieldBorderColor"), width: 1)
    
    private let endDateButton = UIButton()
        .setInitState()
        .setTitleLabel(title: "종료일시")
        .setImage(imageName: "endFlag")
        .setBorder(color: UIColor(named: "textFieldBorderColor"), width: 1)
    
    private var cancellable = Set<AnyCancellable>()
    
    weak var delegate: ScheduleDetailTitleDelegate?
    
    override init(title: String) {
        super.init(title: title)
        translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
        bindAction()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [startDateButton, endDateButton].forEach {
            $0.setShadow()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        super.configureUI()
        
        [titleTextField, startDateButton, endDateButton].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: super.navigationTitleLabel.bottomAnchor, constant: 18),
            titleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            startDateButton.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            startDateButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            startDateButton.trailingAnchor.constraint(equalTo: titleTextField.centerXAnchor, constant: -8),
            startDateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            endDateButton.leadingAnchor.constraint(equalTo: titleTextField.centerXAnchor, constant: 8),
            endDateButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            endDateButton.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            endDateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        titleTextField.setContentHuggingPriority(.required, for: .vertical)
    }
}

private extension ScheduleDetailTitleView {
    func bindAction() {
        titleTextField.textPublisher
            .compactMap { $0 }
            .sink { self.delegate?.scheduleDetailTitleView(with: self, title: $0) }
            .store(in: &cancellable)
        
        startDateButton.tapPublisher
            .sink { _ in self.delegate?.scheduleDetailTitleView(didTapStartTime: self) }
            .store(in: &cancellable)
    }
}

private extension UIButton {
    func setTitleLabel(title: String) -> UIButton {
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14)
        setTitleColor(UIColor(named: "textColor"), for: .normal)
        return self
    }
    
    func setImage(imageName: String) -> UIButton {
        let image = UIImage(named: imageName)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        contentHorizontalAlignment = .leading
        setImage(image, for: .normal)
        return self
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1.0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
    }
    
    func setBorder(color: UIColor?, width: CGFloat) -> UIButton {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
        return self
    }
    
    func setInitState() -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 12
        return self
    }
}
