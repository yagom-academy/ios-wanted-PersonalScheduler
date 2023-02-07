//
//  MainViewController.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/06.
//

import UIKit

class MainViewController: UIViewController {
    
    let listView = ListView()
    var scheduleList: [Schedule] = [Schedule(
        title: "두번째,세번째 UI 구현",
        body: "점심전까지 두번째 뷰 구현",
        startDate: Date(),
        endDate: Date())
    ] {
        didSet {
            listView.reloadTableViewData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        listView.configureTableView(with: self)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Personal Scheduler"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "추가",
            style: .done,
            target: self,
            action: #selector(tapRightBarButton)
        )
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
    
    @objc
    private func tapRightBarButton() {
        let presentViewController = ScheduleInfoViewController()
        
        presentViewController.modalPresentationStyle = .overCurrentContext
        
        navigationController?.present(presentViewController, animated: true)
    }
}

extension MainViewController: UITableViewDelegate {}

extension MainViewController: UITableViewDataSource {
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
