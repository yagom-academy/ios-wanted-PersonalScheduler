//
//  ScheduleDetailViewController.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class ScheduleDetailViewController: UIViewController {
    private let navigationTitleView = ScheduleDetailTitleView(title: "생성하기")
    private let bodyTextView = UITextView()
        .setInitState()
        .setBorder(color: UIColor(named: "textFieldBorderColor"), width: 1)
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.backgroundColor = UIColor(named: "AccentColor")
        button.titleEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "NanumGothicOTFExtraBold", size: 18)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bodyTextView.setShadow()
    }
}

private extension ScheduleDetailViewController {
    func configureUI() {
        addSafeArea()
        addChildComponents()
        setUpLayout()
    }
    
    func addSafeArea() {
        additionalSafeAreaInsets.top += 16
        additionalSafeAreaInsets.left += 16
        additionalSafeAreaInsets.bottom += 16
        additionalSafeAreaInsets.right += 16
    }
    
    func addChildComponents() {
        [
            navigationTitleView,
            bodyTextView,
            saveButton
        ].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            navigationTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationTitleView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationTitleView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.35),
            
            bodyTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            bodyTextView.topAnchor.constraint(equalTo: navigationTitleView.bottomAnchor, constant: 24),
            bodyTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -80),
            
            saveButton.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

private extension UITextView {
    func setInitState() -> UITextView {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        textContainerInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        return self
    }
    
    func setShadow() {
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1.0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
    }
    
    func setBorder(color: UIColor?, width: CGFloat) -> UITextView {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
        return self
    }
}

#if DEBUG
import SwiftUI

struct ScheduleDetailViewPreview: PreviewProvider {
    static var previews: some View {
        ScheduleDetailViewController()
            .showPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
