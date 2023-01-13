//
//  ImageTextView.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import UIKit

final class ImageTextView: UIView {
    private var placeholder = ""

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .lightGray
        return textView
    }()

    private let textCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .systemRed
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(image: UIImage?, placeholder: String) {
        super.init(frame: .zero)
        self.imageView.image = image
        self.placeholder = placeholder
        translatesAutoresizingMaskIntoConstraints = false
        setUpTextView()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUpTextView() {
        textView.delegate = self
        textView.text = placeholder
    }

    private func layout() {
        [imageView, textView, textCountLabel].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: textView.topAnchor, constant: 5),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            textView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            textCountLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 5),
            textCountLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -5)
        ])
    }
}

extension ImageTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .label
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .systemGray4
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        self.textCountLabel.text = "최대 500자까지만 작성할 수 있습니다. \(textView.text.count)/500"
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textViewText = textView.text,
              let rangeToChange = Range(range, in: textViewText) else { return false }

        let updatedText = textViewText.replacingCharacters(in: rangeToChange, with: text)
        if updatedText.count >= 450 {
            self.textCountLabel.isHidden = false
        } else {
            self.textCountLabel.isHidden = true
        }
        return updatedText.count <= 500
    }
}
