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
    
    // MARK: Internal Properties
    
    var userID = String()
    var scheduleList: [Schedule] = []
    let listView = ListView()
    
    // MARK: Private Properties
    
    private var editedListCount: Int?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        configureListView()
    }
    
    // MARK: Internal Methods
    
    func configureScheduleList(data: [Schedule]) {
        scheduleList = data
        listView.reloadTableViewData()
    }
    
    // MARK: Private Methods
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.hidesBackButton = true

        navigationItem.title = NameSpace.navigationItemTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: NameSpace.RightBarButtonItemImageName),
            style: .done,
            target: self,
            action: #selector(tapRightBarButton)
        )
        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: NameSpace.backBarButtonItem,
            style: .done,
            target: self,
            action: nil
        )
    }
    
    private func configureListView() {
        listView.configureTableView(with: self)
        listView.configureAddButton(target: self, action: #selector(tapAddButton))
    }
    
    private func updateUserScheduleData() {
        scheduleList.sort(by: { $0.startTimeInterval1970 < $1.startTimeInterval1970 })
        
        let jsonScheduleList = JSONEncoder().encodeScheduleList(scheduleList)
        let path = Firestore.firestore().collection(userID).document(NameSpace.document)
        
        path.updateData([NameSpace.dataKey : jsonScheduleList])
        
        listView.reloadTableViewData()
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
            updateUserScheduleData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushViewController = ScheduleInfoViewController()
        
        pushViewController.delegate = self
        pushViewController.dataManageMode = .read
        pushViewController.savedSchedule = scheduleList[indexPath.row]
        
        editedListCount = indexPath.row
        
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
            scheduleList.sort(by: { $0.startTimeInterval1970 < $1.startTimeInterval1970 })
            
            let data = scheduleList[indexPath.row]
            let date = Date().timeIntervalSince1970
                
            if data.startTimeInterval1970 <= date &&
                data.endTimeInterval1970 >= date {
                cell.configureDateLabel(color: .label)
            } else if data.startTimeInterval1970 < date {
                cell.configureDateLabel(color: .systemRed)
            } else if data.startTimeInterval1970 > date {
                cell.configureDateLabel(color: .blue)
            }
        
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
            updateUserScheduleData()
        case .edit:
            if let editedListCount = editedListCount {
                scheduleList[editedListCount] = data
                updateUserScheduleData()
            }
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
            let pushViewController = ScheduleInfoViewController()
            
            pushViewController.delegate = self
            pushViewController.dataManageMode = .create
            
            navigationController?.pushViewController(pushViewController, animated: true)
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

// MARK: - NameSpace

private enum NameSpace {
    static let navigationItemTitle = "Personal Scheduler"
    static let RightBarButtonItemImageName = "Logout.png"
    static let backBarButtonItem = "취소"
    static let document = "Personal"
    static let dataKey = "Schedule"
}
