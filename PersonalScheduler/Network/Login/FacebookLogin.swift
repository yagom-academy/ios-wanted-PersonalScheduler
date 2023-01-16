//
//  FacebookLogin.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/13.
//

import Foundation
import FacebookLogin

final class FacebookLogin: Login {
    func getId() -> Observable<Result<String, Error>?> {
        let observer: Observable<Result<String, Error>?> = .init(nil)
        if let id = AccessToken.current?.userID {
            observer.value = .success(id)
        } else {
            observer.value = .failure(LoginError.facebookLoadedError)
        }
        return observer
    }
}
