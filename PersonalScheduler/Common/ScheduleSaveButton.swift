//
//  ScheduleSaveButton.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/11.
//

import UIKit

class ScheduleSaveButton: UIButton {
    private func setting() {
        self.setTitle("저장하기", for: .normal)
        self.setTitleColor(.black, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
