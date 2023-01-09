//
//  LogoImageButton.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class LogoImageButton: UIButton {
    
    init(width: CGFloat, height: CGFloat, image: UIImage) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        setupConstraints(width: width, height: height)
        renderImage(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.layer.cornerRadius = width / 2
        self.layer.backgroundColor = UIColor.systemGray5.cgColor
    }
    
    private func renderImage(image: UIImage) {
        self.imageView?.contentMode = .scaleToFill
        self.setImage(image, for: .normal)
    }
}
