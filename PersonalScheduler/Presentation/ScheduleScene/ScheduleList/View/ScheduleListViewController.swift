//
//  ScheduleListViewController.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class ScheduleListViewController: UIViewController {
    private let scheduleCollectionView: ScheduleCollectionView
    private let viewModel: ScheduleListViewModel
    
    init(with viewModel: ScheduleListViewModel) {
        self.viewModel = viewModel
        scheduleCollectionView = ScheduleCollectionView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
        setupCollectionView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            do {
                try await viewModel.fetchData()
            } catch {
                print(error)
            }
        }
    }
    
    
    private func setupInitialView() {
        view = scheduleCollectionView
        view.backgroundColor = .systemGray6
    }
    
    private func setupCollectionView() {
        scheduleCollectionView.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Schedule"
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
    }
    
    private func bindViewModel() {
        viewModel.scheduleList.bind { scheduleList in
            DispatchQueue.main.async {
                self.scheduleCollectionView.appendData(with: scheduleList)
            }
        }
        Task {
            do {
                try await viewModel.fetchData()
            } catch {
                print(error)
            }
        }
    }
    
    @objc private func rightBarButtonTapped() {
        print("우측상단 버튼탭")
        viewModel.createNewSchedule()
    }
}

extension ScheduleListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath.row)
    }
}
