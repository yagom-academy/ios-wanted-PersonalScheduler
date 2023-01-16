//
//  LoginManager.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/11.
//

import Foundation

protocol LoginManagerAble {
    func getUserId(loginInfo: LoginInfo) -> Observable<Result<String, Error>?>
}

class DefaultLoginManager: LoginManagerAble {
    static var userDefaultKey = "UserId"
    
    private let firebaseManager: FirebaseManagerable
    
    init(firebaseManager: FirebaseManagerable = FirebaseManager.shared) {
        self.firebaseManager = firebaseManager
    }
    
    //만약 등록이 되지 않았다면 등록
    func getUserId(loginInfo: LoginInfo) -> Observable<Result<String, Error>?> {
        let returnResult: Observable<Result<String, Error>?> = .init(nil)
        firebaseManager.readOne(loginInfo) {
            [weak self] result in
            switch result {
            case .success(let success):
                returnResult.value = .success(success.userId)
            case .failure(_):
                do {
                    try self?.firebaseManager.create(loginInfo)
                    returnResult.value = .success(loginInfo.userId)
                } catch {
                    returnResult.value = .failure(FirebaseError.createError)
                }
            }
        }
        return returnResult
    }
}
