//
//  Observable.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

final class Observable<T> {
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func subscribe(listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
