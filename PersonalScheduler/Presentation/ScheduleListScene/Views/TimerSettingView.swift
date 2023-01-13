//
//  TimerSettingView.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import UIKit

final class TimerSettingView: UIView {

    private enum CurrentSelected {
        case start
        case end
    }

    var startTime = Date()
    var endTime = Date()
    private let imageWidthHeight: CGFloat = 30
    private var currentSelected: CurrentSelected = .start {
        didSet {
            datePickerView.date =  currentSelected == .start ? startTime : endTime
        }
    }

    private let clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock")
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let startView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.isUserInteractionEnabled = true
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()

    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "1월 12일 (금)"
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()

    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "오전 11시 00분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let endView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.isUserInteractionEnabled = true
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()

    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "1월 13일 (토)"
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()

    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "오후 11시 30분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()

    private let datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 5
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.calendar = Calendar.current
        datePicker.locale = Locale.current
        datePicker.timeZone = TimeZone.current
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        datePicker.isHidden = true
        datePicker.alpha = 0.3
        return datePicker
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layout()
        addTapGesture()
        setLabelContents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setLabelContents() {
        let timeDateFormatter = DateFormatter()
        timeDateFormatter.dateFormat = "a hh시 mm분"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 (E)"
        datePickerView.date = Date()
        startTimeLabel.text = timeDateFormatter.string(from: datePickerView.date)
        startDateLabel.text = dateFormatter.string(from: datePickerView.date)
        endTimeLabel.text = timeDateFormatter.string(from: datePickerView.date)
        endDateLabel.text = dateFormatter.string(from: datePickerView.date)
    }

    private func layout() {
        [clockImageView, startView, endView, datePickerView, arrowImageView].forEach {
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            clockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            clockImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            clockImageView.heightAnchor.constraint(equalToConstant: imageWidthHeight),
            clockImageView.widthAnchor.constraint(equalTo: clockImageView.heightAnchor),

            arrowImageView.widthAnchor.constraint(equalToConstant: imageWidthHeight),
            arrowImageView.heightAnchor.constraint(equalToConstant: imageWidthHeight),

            startView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            startView.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 15),

            arrowImageView.leadingAnchor.constraint(equalTo: startView.trailingAnchor, constant: 5),
            arrowImageView.centerYAnchor.constraint(equalTo: startView.centerYAnchor),
            arrowImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: imageWidthHeight / 2),

            endView.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: 5),
            endView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            endView.topAnchor.constraint(equalTo: topAnchor, constant: 10),

            datePickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePickerView.topAnchor.constraint(equalTo: startView.bottomAnchor, constant: 10),
            datePickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        [startDateLabel, startTimeLabel].forEach { startView.addSubview($0) }
        [endDateLabel, endTimeLabel].forEach { endView.addSubview($0) }

        NSLayoutConstraint.activate([
            startDateLabel.centerXAnchor.constraint(equalTo: startView.centerXAnchor),
            startDateLabel.topAnchor.constraint(equalTo: startView.topAnchor, constant: 5),
            startTimeLabel.centerXAnchor.constraint(equalTo: startView.centerXAnchor),
            startTimeLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 5),
            startTimeLabel.bottomAnchor.constraint(equalTo: startView.bottomAnchor, constant: -5),

            endDateLabel.centerXAnchor.constraint(equalTo: endView.centerXAnchor),
            endDateLabel.topAnchor.constraint(equalTo: endView.topAnchor, constant: 5),
            endTimeLabel.centerXAnchor.constraint(equalTo: endView.centerXAnchor),
            endTimeLabel.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 5),
            endTimeLabel.bottomAnchor.constraint(equalTo: endView.bottomAnchor, constant: -5)
        ])
    }

    private func addTapGesture() {
        [startView, startTimeLabel, startDateLabel].forEach {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleStartDateTap(_:))))
        }

        [endView, endTimeLabel, endDateLabel].forEach {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEndDateTap(_:))))
        }
    }

    @objc
    private func datePickerChanged(_ sender: UIDatePicker) {
        let timeDateFormatter = DateFormatter()
        timeDateFormatter.dateFormat = "a hh시 mm분"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 (E)"
        switch currentSelected {
        case .start:
            startTimeLabel.text = timeDateFormatter.string(from: datePickerView.date)
            startDateLabel.text = dateFormatter.string(from: datePickerView.date)
        case .end:
            endTimeLabel.text = timeDateFormatter.string(from: datePickerView.date)
            endDateLabel.text = dateFormatter.string(from: datePickerView.date)
        }
    }

    @objc
    private func handleStartDateTap(_ sender: UITapGestureRecognizer) {
        startView.layer.borderWidth = startView.layer.borderWidth == 0 ? 1 : 0
        endView.layer.borderWidth = 0
        showDatePickerViewIsHiddenAnimation(didModeChanged: currentSelected == .end)
        currentSelected = .start
    }

    @objc
    private func handleEndDateTap(_ sender: UITapGestureRecognizer) {
        endView.layer.borderWidth = endView.layer.borderWidth == 0 ? 1 : 0
        startView.layer.borderWidth = 0
        showDatePickerViewIsHiddenAnimation(didModeChanged: currentSelected == .start)
        currentSelected = .end
    }

    private func showDatePickerViewIsHiddenAnimation(didModeChanged: Bool) {
        if didModeChanged && !datePickerView.isHidden { return }

        if datePickerView.isHidden {
            self.datePickerView.isHidden.toggle()
            UIView.animate(withDuration: 0.3, animations: {
                self.datePickerView.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.datePickerView.alpha = 0
            }) { _ in
                self.datePickerView.isHidden.toggle()
            }
        }
    }
}
