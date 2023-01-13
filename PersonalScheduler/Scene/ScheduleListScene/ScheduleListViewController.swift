//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit

class ScheduleListViewController: UIViewController {
    private let scheduleTableview: UITableView = {
        let tableVeiw = UITableView(frame: .zero, style: .grouped)
        tableVeiw.backgroundColor = .systemBackground
        tableVeiw.register(ScheduleListTableViewCell.self,
                           forCellReuseIdentifier: ScheduleListTableViewCell.identifier)
        tableVeiw.translatesAutoresizingMaskIntoConstraints = false
        return tableVeiw
    }()
    
    private let scheduleViewModel: ScheduleViewModel
    
    init(_ viewModel: ScheduleViewModel) {
        self.scheduleViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadSchedules()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        bind()
    }
    
    private func bind() {
        scheduleViewModel.schedules
            .subscribe { [weak self] schedules in
                self?.scheduleTableview.reloadData()
                
                var newSection: [String] = []
                
                schedules.forEach {
                    let startTime = $0.startTime.convertToString()
                    if newSection.contains(startTime) == false {
                        newSection.append(startTime)
                    }
                }
                
                self?.scheduleViewModel.sections.value = newSection
        }
        
        scheduleViewModel.sections
            .subscribe { [weak self] _ in
                self?.scheduleTableview.reloadData()
            }
    }
    
    private func loadSchedules() {
        scheduleViewModel.fetch()
    }
}

//MARK: TableView DataSource & Delegate
extension ScheduleListViewController: UITableViewDataSource, UITableViewDelegate {
    private func setupTableView() {
        scheduleTableview.dataSource = self
        scheduleTableview.delegate = self
        scheduleTableview.rowHeight = view.bounds.height * 0.1
    }
    
    private func setupInitialTableView() {
        let initialLabel = UILabel()
        initialLabel.frame = CGRect(x: .zero, y: .zero, width: view.bounds.width, height: view.bounds.height)
        initialLabel.text = "저장된 일정이 없습니다."
        initialLabel.textAlignment = .center
        scheduleTableview.backgroundView = initialLabel
    }
    
    private func scheduleInSection(at section: Int) -> [Schedule] {
        let sections = scheduleViewModel.sections.value
        let schedules = scheduleViewModel.schedules.value
        
        return schedules.filter {
            $0.startTime.convertToString() == sections[section]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let sections = scheduleViewModel.sections.value
        scheduleTableview.backgroundView = .none
        
        guard sections.isEmpty == false else{
            setupInitialTableView()
            return 0
        }
            
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return scheduleViewModel.sections.value[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleInSection(at: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleListTableViewCell.identifier,
                                                       for: indexPath) as? ScheduleListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.congigure(with: scheduleInSection(at: indexPath.section)[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSchedule = scheduleInSection(at: indexPath.section)[indexPath.row]
        let detailViewController = ScheduleDetailViewController(scheduleViewModel,
                                                                viewMode: .display(schedule: selectedSchedule))
        
        navigationController?.pushViewController(detailViewController,
                                                 animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        headerView.textLabel?.font = .preferredFont(forTextStyle: .headline)
        headerView.textLabel?.textColor = .label
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteSchedule = scheduleInSection(at: indexPath.section)[indexPath.row]
            scheduleViewModel.delete(deleteSchedule)
        }
    }
}

//MARK: Setup View
extension ScheduleListViewController {
    private func setupView() {
        setupConstraint()
        setupNavigationBar()
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraint() {
        view.addSubview(scheduleTableview)
        
        NSLayoutConstraint.activate([
            scheduleTableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scheduleTableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -8),
            scheduleTableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: 16),
            scheduleTableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -16),
        ])
    }
    
    private func setupNavigationBar() {
        let addScheduleBarButton = UIBarButtonItem(image: ScheduleImage.add,
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(addScheduleBarButtonTapped))
        
        navigationItem.title = ScheduleInfo.scheduleList
        navigationItem.rightBarButtonItem = addScheduleBarButton
    }
    
    @objc private func addScheduleBarButtonTapped() {
        let detailViewController = ScheduleDetailViewController(scheduleViewModel,
                                                                viewMode: .create)
        
        navigationController?.pushViewController(detailViewController,
                                                 animated: true)
    }
}
