//
//  ListViewController.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/09.
//

import UIKit

final class ListViewController: UIViewController {
    private let viewModel: ListViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraint()
    }
    
    init(_ viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIConstraint
extension ListViewController {
    private func setupNavigationBar() {
        title = viewModel.fetchName() + "님의 Scedule"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupView() {
        view.backgroundColor = .red
    }
    
    private func setupConstraint() {
        
    }
}
