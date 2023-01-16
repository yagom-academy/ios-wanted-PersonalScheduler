//
//  Login.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/10.
//

import Foundation

protocol Login {
    func getId() -> Observable<Result<String, Error>?>
}
