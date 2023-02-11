//
//  SegmentControlView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit
import Combine

protocol ScheduleSegmentControlDelegate: AnyObject {
    func scheduleSegmentControl(with segmentControl: ScheduleSegmentControlView, changedIndex: Int)
}

final class ScheduleSegmentControlView: UIView {
    private var itemTitles: [String] = []
    
    private var buttons: [UIButton] = []
    private var stackView = UIStackView()
    private var selectedColor: UIColor = .white
    
    private var cancellable = Set<AnyCancellable>()
    weak var delegate: ScheduleSegmentControlDelegate?
    
    convenience init(frame: CGRect, titles: [String]) {
        self.init(frame: frame)
        self.itemTitles = titles
        
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        backgroundColor = .white
    }
    
    private func updateView() {
        createButtons()
        configureStackView()
        
        bindAction()
    }
    
    private func createButtons() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        for title in itemTitles {
            let button = SegmentButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .clear
            button.titleLabel?.textColor = .black
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            buttons.append(button)
        }
        
        buttons[0].isSelected = true
    }
    
    private func configureStackView() {
        stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func bindAction() {
        buttons.enumerated().forEach { index, item in
            item.tapPublisher
                .sink { [weak self] _ in
                    self?.changeButtonsState(item, index: index)
                }
                .store(in: &cancellable)
        }
    }
    
    private func changeButtonsState(_ sender: UIButton, index: Int) {
        buttons.forEach { $0.isSelected = false }
        sender.isSelected = true
        delegate?.scheduleSegmentControl(with: self, changedIndex: index)
    }
}
