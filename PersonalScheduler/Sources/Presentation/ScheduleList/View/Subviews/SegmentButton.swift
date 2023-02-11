//
//  SegmentButton.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class SegmentButton: UIButton {
    override var isSelected: Bool {
        didSet {
            changeButtonState()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        
        let textColor = UIColor(named: "titleAccentColor")
        setTitleColor(.white, for: .selected)
        setTitleColor(textColor, for: .normal)
    }
    
    private func changeButtonState() {
        UIView.animate(withDuration: 1, delay: 0) { [weak self] in
            guard let isSelected = self?.isSelected else { return }
            
            if isSelected {
                self?.backgroundColor = UIColor(named: "segementSelectedColor")
            } else {
                self?.backgroundColor = .white
            }
        }
    }
}
