//
//  SchedulePlusButton.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import UIKit

class SchedulePlusButton: UIButton {
    
    private func setting() {
        self.setImage(UIImage(systemName: "calendar.badge.plus"), for: .normal)
        self.tintColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
