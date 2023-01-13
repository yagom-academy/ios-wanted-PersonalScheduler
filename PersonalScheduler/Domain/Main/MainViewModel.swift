//
//  MainViewModel.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/11.
//

import Foundation
import FacebookLogin

protocol MainvViewModelInput {
    func viewDidLoad()
    func login(loginType: LoginType)
}

protocol MainViewModelOutput {
    var userId: Observable<String?> { get }
    var errorMessage: Observable<String?> { get }
}

protocol MainViewModelable: MainViewModelOutput, MainvViewModelInput {}

final class MainViewModel: MainViewModelable {
    
    private enum Constant {
        static var userDefaultKey = "UserId"
    }
    
    //Mark Output
    var userId: Observable<String?>
    var errorMessage: Observable<String?>
    private var loginManager: LoginManagerAble
    
    init(loginManager: LoginManagerAble = DefaultLoginManager()) {
        userId = .init(nil)
        errorMessage = .init(nil)
        self.loginManager = loginManager
    }
    
    //MARK - Input
    func viewDidLoad() {
        userId.value = loadUserId()
    }
    
    func login(loginType: LoginType) {
        switch loginType {
        case .kakao:
            let kakao = KakaoLogin()
            setLoginObserver(login: kakao, type: .kakao)
        case .facebook:
            let facebook = FacebookLogin()
            setLoginObserver(login: facebook, type: .facebook)
        }
    }
    
    private func setLoginObserver(login: Login, type: LoginType) {
        let _ = login.getId().observe(on: self) { [weak self] result in
            switch result {
            case .success(let id):
                guard let self = self else { return }
                let logininfo = LoginInfo(id: id, loginType: type)
                let observeUserId = self.loginManager.getUserId(loginInfo: logininfo)
                observeUserId.observe(on: self, observerBlock: { result in
                    switch result {
                    case .success(let userId):
                        self.userId.value = userId
                        UserDefaults.standard.setValue(userId, forKey: Constant.userDefaultKey)
                    case .failure(let error):
                        self.errorMessage.value = error.localizedDescription
                    case .none:
                        break
                    }})
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            case .none:
                break
            }
        }
    }
}

private extension MainViewModel {
    func loadUserId() -> String? {
        let userId = UserDefaults.standard.string(forKey: Constant.userDefaultKey)
        return userId
    }
}
