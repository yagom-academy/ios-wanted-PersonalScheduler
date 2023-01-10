//
//  Login.swift
//  PersonalScheduler
//
//  Created by 곽우종 on 2023/01/10.
//

import Foundation

protocol Login {
    func getEmail() -> Observable<Result<String, Error>?>
}
