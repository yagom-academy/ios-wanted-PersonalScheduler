//
//  DataManageable.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/13.
//

import Foundation

protocol DataManageable: AnyObject {
    func updateProcess(data: Schedule)
    func uploadData(mode: Mode, _ data: Schedule)
}

protocol EventManageable: AnyObject {
    func presentDetailView(mode: Mode, data: Schedule?)
}
