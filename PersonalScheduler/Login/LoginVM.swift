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
        let isLoginable: Dynamic<Error?> = Dynamic(nil)
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
                KakaoLoginManager.shared.login() { error in
                    if let error {
                        self?.output.isLoginable.value = error
                    } else {
                        self?.output.isLoginable.value = nil
                    }
                }
            case .facebook:
                print("페이스북")
            }
        }
    }
}
