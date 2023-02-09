//
//  EditViewController.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit

final class EditViewController: UICollectionViewController {
    private var editingSchedule: Schedule
    private var isAdding: Bool
    private var onChange: ((Schedule) -> Void)

    init(schedule: Schedule, isAdding: Bool, onChange: @escaping (Schedule) -> Void) {
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
}
