//
//  LoginVM.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import Foundation

class LoginVM: ViewModel {
    
    struct Input {
        let loginTrigger: Dynamic<LoginType> = Dynamic(LoginType.apple)
    }
    
    struct Output {
        let isLoginable: Dynamic<Bool> = Dynamic(false)
        var errorMessage: String = ""
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        inputBind()
    }
    
    private func inputBind() {
        input.loginTrigger.bind { [weak self] loginType in
            switch loginType {
            case .apple:
                print("애플")
            case .kakao:
                KakaoLoginManager.shared.kakaoLogin() { loginResult, error in
                    switch loginResult {
                    case .loginSuccess:
                        self?.output.isLoginable.value = true
                    case .loginFail:
                        self?.output.isLoginable.value = false
                        self?.output.errorMessage = error!.localizedDescription
                    }
                }
            case .facebook:
                print("페이스북")
            }
        }
    }
}
