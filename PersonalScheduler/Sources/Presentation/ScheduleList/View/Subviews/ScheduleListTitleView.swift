//
//  ScheduleListTitleView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class ScheduleListTitleView: NavigationBar {
    private let segmentController: ScheduleSegmentControlView = {
        let segmentControl = ScheduleSegmentControlView(frame: .zero, titles:  ["전체", "진행중", "완료"])
        return segmentControl
    }()
    
    override init(title: String) {
        super.init(title: title)
        navigationTitleLabel.text = title
        translatesAutoresizingMaskIntoConstraints = false
        segmentController.delegate = self
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        super.configureUI()
        
        addSubview(segmentController)
        
        NSLayoutConstraint.activate([
            segmentController.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentController.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentController.topAnchor.constraint(equalTo: super.navigationTitleLabel.bottomAnchor, constant: 25),
            segmentController.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
}

extension NavigationBar: ScheduleSegmentControlDelegate {
    func scheduleSegmentControl(
        with segmentControl: ScheduleSegmentControlView,
        changedIndex: Int
    ) {
        // TODO: - 변경되는 사항 알려주는 메서드 추가하기
        print(changedIndex)
    }
}
