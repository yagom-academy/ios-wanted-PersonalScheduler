//
//  ListViewController.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit

final class ListViewController: UIViewController {
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureNavigationItem()
        configureHierarchy()
    }

    private func configureCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }

    private func configureNavigationItem() {
        navigationItem.title = NSLocalizedString("Personal Scheduler", comment: "Scheduler List ViewController Title")
        navigationItem.hidesBackButton = true
    }

    private func configureHierarchy() {
        guard let collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
