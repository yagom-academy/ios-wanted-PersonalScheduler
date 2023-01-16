//
//  SigninViewModel.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/10.
//

struct SigninViewModelActions {

}

protocol SigninViewModelInput {
    func registerButtonTapped(_ loginInfo: LoginInfo, _ completion: (String) -> Void) async throws
}
protocol SigninViewModelOutput {}
protocol SigninViewModel: SigninViewModelInput, SigninViewModelOutput {}

final class DefaultSigninViewModel: SigninViewModel {
    private let actions: SigninViewModelActions?
    private let firebaseAuthUseCase: FirebaseAuthUseCase
    
    init(
        actions: SigninViewModelActions? = nil,
        firebaseAuthUseCase: FirebaseAuthUseCase
    ) {
        self.actions = actions
        self.firebaseAuthUseCase = firebaseAuthUseCase
    }
    
    func registerButtonTapped(_ loginInfo: LoginInfo, _ completion: (String) -> Void) async throws {
        do {
            let email = try await firebaseAuthUseCase.fetchUserEmail(from: loginInfo)
            completion(email)
        } catch let error {
            print(error)
        }
    }
}
