//
//  Observable.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/10.
//

final class Observable<T: Equatable> {
    var value: T {
        didSet {
            if oldValue != value {
                listener?(value)
            }
        }
    }
    var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        closure(value)
        self.listener = closure
    }
}
