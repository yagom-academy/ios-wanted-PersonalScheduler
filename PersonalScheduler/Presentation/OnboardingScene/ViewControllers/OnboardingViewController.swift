//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit

final class OnboardingViewController: UIViewController {

    private var coordinator: OnboardingCoordinator?
    private let viewModel = OnboardingViewModel()

    private lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OnboardingCollectionViewCell.self,
                                forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewModel.onboardingCardImages.count
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addAction(UIAction { _ in
            self.onboardingCollectionView.setContentOffset(CGPoint(
                x: CGFloat(pageControl.currentPage) *  CGFloat(self.onboardingCollectionView.frame.width),
                y: self.onboardingCollectionView.contentOffset.y
            ), animated: true)
        }, for: .valueChanged)
        return pageControl
    }()

    private lazy var appleLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Apple로 로그인하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { [weak self] action in
            self?.viewModel.appleLoginButtonTapped {
                self?.coordinator?.loginFinished()
            }
        }, for: .touchUpInside)
        return button
    }()

    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Kakao로 로그인하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemYellow
        button.addAction(UIAction { [weak self] action in
            self?.viewModel.kakaoLoginButtonTapped {
                self?.coordinator?.loginFinished()
            }
        }, for: .touchUpInside)
        return button
    }()

    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }

    private func layout() {
        [onboardingCollectionView, pageControl, appleLoginButton, kakaoLoginButton].forEach {
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            onboardingCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            onboardingCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            onboardingCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            onboardingCollectionView.heightAnchor.constraint(equalTo: onboardingCollectionView.widthAnchor),

            pageControl.topAnchor.constraint(equalTo: onboardingCollectionView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: onboardingCollectionView.centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 200),
            pageControl.heightAnchor.constraint(equalToConstant: 50),

            kakaoLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            kakaoLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 50),

            appleLoginButton.bottomAnchor.constraint(equalTo: kakaoLoginButton.topAnchor, constant: -10),
            appleLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            appleLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.onboardingCardImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setUpContents(title: viewModel.onboardingCardTitles[indexPath.row],
                           image: viewModel.onboardingCardImages[indexPath.row])
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if onboardingCollectionView.frame.width == 0 { return }
        let page = Int(floor(onboardingCollectionView.contentOffset.x / onboardingCollectionView.frame.width))
        pageControl.currentPage = page
    }
}
