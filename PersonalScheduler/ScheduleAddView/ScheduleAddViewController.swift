//
//  ScheduleAddViewController.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/12.
//

import UIKit
import Combine
import FirebaseAuth

final class ScheduleAddViewController: UIViewController {
    private let textViewPlaceholder = "내용을 입력하세요"
    private var scheduleAddViewModel: ScheduleAddViewModel
    private var cancelable = Set<AnyCancellable>()

    init(scheduleAddViewModel: ScheduleAddViewModel?, isEditing: Bool) {
        self.scheduleAddViewModel = scheduleAddViewModel ?? ScheduleAddViewModel(readSchedule: ScheduleModel(documentId: "",
                                                                                                             title: "",
                                                                                                             startDate: "",
                                                                                                             mainText: ""))
        super.init(nibName: nil, bundle: nil)
        if isEditing {
            self.navigationItem.rightBarButtonItem = editButton
        } else {
            self.navigationItem.rightBarButtonItem = saveButton
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: " 제목", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.textColor = .black
        textField.textAlignment = .left
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.font = UIFont(name: "largeTitle", size: 15)
        textField.layer.borderColor = UIColor.blue.cgColor
        return textField
    }()

    private lazy var mainBodyTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.blue.cgColor
        textView.layer.cornerRadius = 5
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.text = self.textViewPlaceholder
        textView.textColor = .lightGray
        textView.delegate = self
        textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private let startedTimeControl: UIDatePicker = {
        let picker = UIDatePicker()
        picker.minimumDate = Date()
        return picker
    }()

    private lazy var remainCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "0/500"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 일기"
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()


    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "저장"
        button.target = self
        button.action = #selector(didTapSaveButton)
        return button
    }()

    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "수정"
        button.target = self
        button.action = #selector(didTapEditButton)
        return button
    }()

    private let informationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setStackView()

        view.addSubview(informationStackView)
        view.addSubview(mainBodyTextView)
        view.addSubview(remainCountLabel)

        setConstraints()
        bind()
        scheduleAddViewModel.onViewDidLoad()
        self.navigationItem.titleView = titleLabel
    }

    private func setStackView() {
        informationStackView.addArrangedSubview(titleTextField)
        informationStackView.addArrangedSubview(startedTimeControl)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            //MARK: informationStackView
            informationStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            informationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            informationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            titleTextField.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: informationStackView.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),

            //MARK: mainBodyTextView
            mainBodyTextView.topAnchor.constraint(equalTo: informationStackView.bottomAnchor, constant: 20),
            mainBodyTextView.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor),
            mainBodyTextView.trailingAnchor.constraint(equalTo: informationStackView.trailingAnchor),
            mainBodyTextView.heightAnchor.constraint(equalToConstant: 400),

            //MARK: reamainCountLabel
            remainCountLabel.topAnchor.constraint(equalTo: mainBodyTextView.bottomAnchor, constant: 20),
            remainCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func updateCountLabel(characterCount: Int) {
        remainCountLabel.text = "\(characterCount)/500"
        remainCountLabel.asColor(targetString: "\(characterCount)", color: characterCount == 0 ? .lightGray : .blue)
    }

    @objc
    private func didTapTextView(_ sender: Any) {
        view.endEditing(true)
    }

    @objc
    private func didTapSaveButton() {
        scheduleAddViewModel.input.tappedSaveButton()
    }

    @objc
    private func didTapEditButton() {
        scheduleAddViewModel.input.tappedEditButton()
    }
}

extension ScheduleAddViewController {
    private func bind() {
        scheduleAddViewModel.output.scheduleSavePublisher
            .sink { [weak self] _ in
                guard let self = self, let uuid = UserDefaults.standard.string(forKey: "uid"), uuid.isEmpty == false else { return }
                FirebaseManager.shared.savedData(
                    user: uuid, document: UUID(), scheduleData: ScheduleModel(firebase: ["title" : self.titleTextField.text ?? "",
                                                                         "startedTime" : self.startedTimeControl.date.formattedString(),
                                                                      "mainBody" : self.mainBodyTextView.text ?? ""]) ?? ScheduleModel(firebase: [:])!)
            }
            .store(in: &cancelable)

        scheduleAddViewModel.output.dismissPublisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancelable)

        scheduleAddViewModel.output.scheduleModelPublisher
            .sink { [weak self] schedule in
                guard let self = self else { return }
                self.titleTextField.text = schedule.title
                self.startedTimeControl.date = schedule.startDate?.toDate() ?? Date()
                self.mainBodyTextView.text = schedule.mainText
            }
            .store(in: &cancelable)

        scheduleAddViewModel.output.scheduleEditPublisher
            .sink { [weak self] schedule in
                guard let self = self, let UUID = UserDefaults.standard.string(forKey: "uid"), UUID.isEmpty == false else { return }
                FirebaseManager.shared.editData(user: UUID,
                                                document: schedule.documentId ?? "",
                                                title: self.titleTextField.text ?? "",
                                                startedTime: self.startedTimeControl.date.toString(),
                                                mainBody: self.mainBodyTextView.text)
            }
            .store(in: &cancelable)
    }
}

extension ScheduleAddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = .lightGray
            updateCountLabel(characterCount: 0)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

        let characterCount = newString.count
        guard characterCount <= 500 else { return false }
        updateCountLabel(characterCount: characterCount)

        return true
    }
}
