//
//  SplashVM.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import Foundation
import FirebaseAuth

class SplashVM: ViewModel {
    
    struct Input {
        let viewDidLoadTrigger: Dynamic<Void> = Dynamic(())
    }
    
    struct Output {
        let splashResult: Dynamic<SplashResultType> = Dynamic(SplashResultType.notRegistered)
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
        input.viewDidLoadTrigger.bind { [weak self] _ in
            self?.checkingUser()
        }
    }
    
    private func checkingUser() {
        if (Auth.auth().currentUser != nil) {
            output.splashResult.value = SplashResultType.registered
        } else {
            output.splashResult.value = SplashResultType.notRegistered
        }
    }
}
