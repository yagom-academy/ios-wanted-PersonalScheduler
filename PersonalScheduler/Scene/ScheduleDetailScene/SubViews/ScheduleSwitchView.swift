//
//  ScheduleSwitchView.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/10.
//

import UIKit

final class ScheduleSwitchView: UIView {
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return switchView
    }()
    
    var isSwitchOn: Bool {
        return switchView.isOn
    }
    
    init(text: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        infoLabel.text = text
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func changeOnOff(_ isEnabled: Bool) {
        switchView.isEnabled = isEnabled
    }
    
    func setupSwitch(_ isOn: Bool) {
        switchView.isOn = isOn
    }
    
    private func setupView() {
        entireStackView.addArrangedSubview(infoLabel)
        entireStackView.addArrangedSubview(switchView)
        
        self.addSubview(entireStackView)
        
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: self.topAnchor),
            entireStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            entireStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            entireStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
