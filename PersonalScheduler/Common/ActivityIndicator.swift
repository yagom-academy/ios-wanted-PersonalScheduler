//
//  ActivityIndicator.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/12.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    
    private func setting() {
        self.style = .large
        self.color = .systemBlue
        self.layer.zPosition = 1
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setting()
    }
}
