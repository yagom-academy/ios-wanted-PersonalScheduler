//
//  Observable.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/08.
//

import Foundation

final class Observable<T> {

    private var listener: ((T) -> Void)?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }


    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
