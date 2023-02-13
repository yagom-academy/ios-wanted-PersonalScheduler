//
//  EditViewController.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit

final class EditViewController: UICollectionViewController {
    private typealias Datasource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>

    private var datasource: Datasource?
    private var schedule: Schedule
    private var editingSchedule: Schedule
    private var isAdding: Bool
    private var onChange: ((Schedule) -> Void)

    init(schedule: Schedule, isAdding: Bool, onChange: @escaping (Schedule) -> Void) {
        self.schedule = schedule
        self.editingSchedule = schedule
        self.isAdding = isAdding
        self.onChange = onChange

        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .firstItemInSection
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        super.init(collectionViewLayout: collectionViewLayout)
        view.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSources()
        configureNavigationItem()
        updateSnapshot()
    }

    private func configureDataSources() {
        guard let collectionView else { return }
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        datasource = Datasource(collectionView: collectionView, cellProvider: { collectionView, indexPath, row in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: row)
        })
    }

    private func configureNavigationItem() {
        if isAdding {
            navigationItem.title = NSLocalizedString("Add Schedule", comment: "Add Schedule ViewController Title")
            navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel,
                                                               primaryAction: UIAction(handler: cancelHandler))
            navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done,
                                                                primaryAction: UIAction(handler: doneAddingHandler))
        } else {
            navigationItem.title = NSLocalizedString("Schedule", comment: "Schedule ViewController Title")
            navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done,
                                                                primaryAction: UIAction(handler: doneEditingHandler))
        }
    }

    private func cancelHandler(_ action: UIAction) {
        dismiss(animated: true)
    }

    private func doneAddingHandler(_ action: UIAction) {
        onChange(editingSchedule)
        dismiss(animated: true)
    }

    private func doneEditingHandler(_ action: UIAction) {
        if editingSchedule != schedule {
            onChange(editingSchedule)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension EditViewController {
    private func updateSnapshot() {
        guard let datasource else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([.title, .date, .body])
        snapshot.appendItems([.header(String(describing: Section.title)), .title(schedule.title)],
                             toSection: .title)
        snapshot.appendItems([.header(String(describing: Section.date)), .date(schedule.scheduleDate)],
                             toSection: .date)
        snapshot.appendItems([.header(String(describing: Section.body)), .body(schedule.body)],
                             toSection: .body)
        datasource.apply(snapshot)
    }

    private func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header):
            cell.contentConfiguration = headerConfiguration(for: cell, with: row)
        case (.title, .title(let title)):
            cell.contentConfiguration = titleConfiguration(for: cell, with: title)
        case (.date, .date(let date)):
            cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        case (.body, .body(let body)):
            cell.contentConfiguration = bodyConfiguration(for: cell, with: body)
        default:
            break
        }
    }

    private func headerConfiguration(for cell: UICollectionViewListCell, with row: Row) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = row.text
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: .headline)
        return contentConfiguration
    }

    private func titleConfiguration(
        for cell: UICollectionViewListCell,
        with title: String
    ) -> TextFieldContentView.Configuration {
        var contentConfiguration = TextFieldContentView.Configuration()
        contentConfiguration.text = title
        contentConfiguration.onChange = { [weak self] title in
            self?.editingSchedule.title = title
        }
        return contentConfiguration
    }

    private func dateConfiguration(
        for cell: UICollectionViewListCell,
        with date: Date
    ) -> DatePickerContentView.Configuration {
        var contentConfiguration = DatePickerContentView.Configuration()
        contentConfiguration.date = date
        contentConfiguration.onChange = { [weak self] date in
            self?.editingSchedule.scheduleDate = date
        }
        return contentConfiguration
    }

    private func bodyConfiguration(
        for cell: UICollectionViewListCell,
        with body: String
    ) -> TextViewContentView.Configuration {
        var contentConfiguration = TextViewContentView.Configuration()
        contentConfiguration.text = body
        contentConfiguration.onChange = { [weak self] body in
            self?.editingSchedule.body = body
        }
        return contentConfiguration
    }
}

extension EditViewController {
    private enum Section: Int, Hashable, CustomStringConvertible {
        case title
        case date
        case body

        var description: String {
            switch self {
            case .title:
                return NSLocalizedString("Title", comment: "Title Section description")
            case .date:
                return NSLocalizedString("Schedule Date", comment: "Date Section description")
            case .body:
                return NSLocalizedString("Body", comment: "Body Section description")
            }
        }
    }

    private enum Row: Hashable {
        case header(String)
        case title(String)
        case date(Date)
        case body(String)

        var text: String? {
            switch self {
            case .header(let text):
                return text
            default: return nil
            }
        }
    }

    private func section(for indexPath: IndexPath) -> Section {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Can't find section")
        }
        return section
    }
}
