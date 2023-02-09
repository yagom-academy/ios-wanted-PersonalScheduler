//
//  ListViewController.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/06.
//

import UIKit
import FirebaseAuth

class ListViewController: UIViewController {
    
    // MARK: Internal Properties
    
    
    // MARK: Private Properties
    
    private let listView = ListView()
    private let scheduleInfoViewController = ScheduleInfoViewController()
    private var scheduleList: [Schedule] = [] {
        didSet {
            listView.reloadTableViewData()
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        configureDelegate()
        listView.configureTableView(with: self)
    }
    
    // MARK: Private Methods
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.hidesBackButton = true

        navigationItem.title = "Personal Scheduler"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Logout.png"),
            style: .done,
            target: self,
            action: #selector(tapLeftBarButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .add,
            style: .done,
            target: self,
            action: #selector(tapRightBarButton)
        )
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "취소",
            style: .done,
            target: self,
            action: #selector(tapBackBarButton)
        )
    }
    
    private func configureDelegate() {
        scheduleInfoViewController.delegate = self
    }
    
    private func configureLayout() {
        view.addSubview(listView)
        
        listView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            listView.widthAnchor.constraint(equalTo: view.widthAnchor),
            listView.heightAnchor.constraint(equalTo: view.heightAnchor),
            listView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            listView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: Action Methods
    
    @objc
    private func tapLeftBarButton() {
        let loginViewController = MainViewController()
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        loginViewController.toggleFacebookLoginButton()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc
    private func tapRightBarButton() {
        presentAddScheduleCheckingAlert()
    }
    
    @objc
    private func tapBackBarButton() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            scheduleList.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushViewController = ScheduleInfoViewController()
        
        pushViewController.mode = .read
        pushViewController.delegate = self
        
        navigationController?.pushViewController(pushViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier,
            for: indexPath) as? ListTableViewCell {
            let data = scheduleList[indexPath.row]
            
            cell.configureLabelText(schedule: data)
            cell.selectionStyle = .none
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - DataSendable

extension ListViewController: DataSendable {
    func sendData(with data: Schedule, mode: ManageMode) {
        switch mode {
        case .create:
            scheduleList.append(data)
        case .edit:
            break
        case .read:
            break
        }
    }
}

// MARK: - AlertPresentable

extension ListViewController: AlertPresentable {
    func presentAddScheduleCheckingAlert() {
        let alert = createAlert(
            title: "입력 확인",
            message: "스케쥴을 추가하시겠습니까?"
        )
        let firstAlertAction = createAlertAction(
            title: "확인"
        ) { [self] in
            scheduleInfoViewController.mode = .create
            navigationController?.pushViewController(scheduleInfoViewController, animated: true)
        }
        let secondAlertAction = createAlertAction(
            title: "취소"
        ) {}
        
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        present(alert, animated: true)
    }
}
