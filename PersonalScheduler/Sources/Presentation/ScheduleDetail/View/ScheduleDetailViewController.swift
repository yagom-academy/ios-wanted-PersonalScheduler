//
//  ScheduleDetailViewController.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class ScheduleDetailViewController: UIViewController {
    private let navigationTitleView = ScheduleDetailTitleView(title: "생성하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
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
            navigationTitleView
        ].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            navigationTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationTitleView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationTitleView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.4),
        ])
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
