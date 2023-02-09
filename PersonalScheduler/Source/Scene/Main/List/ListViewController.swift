//
//  ListViewController.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/06.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

final class ListViewController: UIViewController {
    
    // MARK: Private Properties
    
    private let listView = ListView()
    private let scheduleInfoViewController = ScheduleInfoViewController()
    private let db = Firestore.firestore()
    private var scheduleList: [Schedule] = [] {
        didSet {
            listView.reloadTableViewData()
            saveUserScheduleData()
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        configureDelegate()
        configureListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        readUserScheduleData()
    }
    
    // MARK: Private Methods
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.hidesBackButton = true

        navigationItem.title = "Personal Scheduler"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Logout.png"),
            style: .done,
            target: self,
            action: #selector(tapRightBarButton)
        )
        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "취소",
            style: .done,
            target: self,
            action: nil
        )
    }
    
    private func configureDelegate() {
        scheduleInfoViewController.delegate = self
    }
    
    private func configureListView() {
        listView.configureTableView(with: self)
        listView.configureAddButton(target: self, action: #selector(tapAddButton))
    }
    
    private func saveUserScheduleData() {
        let jsonScheduleData = try? JSONEncoder().encode(scheduleList)
        
        guard let jsonScheduleData = jsonScheduleData,
              let dataString = String(data: jsonScheduleData, encoding: .utf8) else { return }
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if let id = user?.email {
                let path = self.db.collection(id).document("Personal")
                path.updateData(["Schedule" : dataString])
            }
        }
    }
    
    private func readUserScheduleData() {
        Auth.auth().addStateDidChangeListener { [self] auth, user in
            if let id = user?.email {
                db.collection(id).getDocuments() { [self] querySnapShot, error in
                    if let error = error {
                        print(error)
                    } else {
                        print("Firebase Read Success")
                        if let documents = querySnapShot?.documents {
                            for document in documents {
                                let datas = document.data().values
                                for value in datas {
                                    let stringValue = "\(value)"
                                    if let jsonData = stringValue.data(using: .utf8) {
                                        let data = try? JSONDecoder().decode([Schedule].self, from: jsonData)
                                        if let datas = data {
                                            scheduleList = datas
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
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
    private func tapRightBarButton() {
        presentLogOutCheckingAlert()
    }
    
    @objc
    private func tapAddButton() {
        presentAddScheduleCheckingAlert()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(view.frame.size.height * 0.11)
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
            title: "데이터 관리",
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
    
    func presentLogOutCheckingAlert() {
        let alert = createAlert(
            title: "로그아웃 확인",
            message: "홈화면으로 이동하시겠습니까?"
        )
        let firstAlertAction = createAlertAction(
            title: "확인"
        ) { [self] in
            let loginViewController = MainViewController()
            
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print("Error signing out: \(signOutError)")
            }
            
            loginViewController.toggleFacebookLoginButton()
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        let secondAlertAction = createAlertAction(
            title: "취소"
        ) {}
        
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        present(alert, animated: true)
    }
}
