//
//  CRUDable.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/09.
//

import Foundation

protocol CRUDable {

    func create(_ event: Event)

    func read(completion: @escaping (Result<[Event], Error>) -> Void)

    func update(_ event: Event)

    func delete(_ event: Event)

    func deleteAll()
}
