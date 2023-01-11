//
//  AuthViewModel.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation
import Combine
import AuthenticationServices

protocol AuthViewModelInput {
    
    func didTapKakaoButton()
    func didTapAppleButton()
    func didTapFacebookButton()
    func viewWillAppear()
    
}

protocol AuthViewModelOutput {
    
    var errorMessage: AnyPublisher<String?, Never> { get }
    var appleAuthorizationController: ASAuthorizationController { get }
    var isLoading: AnyPublisher<Bool, Never> { get }
    var isCompletedLogin: AnyPublisher<Bool, Never> { get }
    
}

protocol AuthViewModel {
    
    var input: AuthViewModelInput { get }
    var output: AuthViewModelOutput { get }
    
    var cancellables: Set<AnyCancellable> { get }
    
}

final class DefaultAuthViewModel: AuthViewModel {
    
    private(set) var cancellables: Set<AnyCancellable> = .init()
    private let authRepository: AuthenticationRepository
    private let keychainStorage: KeyChainStorageService
    private let userRepository: UserRepository
    
    private var _errorMessage = CurrentValueSubject<String?, Never>(nil)
    private var _isSuccessLogin = CurrentValueSubject<Bool, Never>(false)
    private var _isLoading = CurrentValueSubject<Bool, Never>(false)
    
    init(
        authRepository: AuthenticationRepository = DefaultAuthenticationRepository(),
        keychainManager: KeyChainStorageService = KeyChainStorage.shard,
        userRepository: UserRepository = DefaultUserRepository()
    ) {
        self.authRepository = authRepository
        self.keychainStorage = keychainManager
        self.userRepository = userRepository
    }
    
}

private extension DefaultAuthViewModel {
    
    func successLogin(_ authentication: Authentication, snsType: SNSType) {
        authRepository.writeToken(authentication: authentication)
        userRepository.register(authentication, snsType: snsType)
        _isSuccessLogin.send(true)
    }
}

extension DefaultAuthViewModel: AuthViewModelInput {
    
    var input: AuthViewModelInput { self }
    
    func viewWillAppear() {
        _isLoading.send(true)
        authRepository.readToken(option: .access)
            .sink(receiveCompletion: { [weak self] complection in
                if case let .failure(error) = complection {
                    debugPrint(error)
                    self?._errorMessage.send("로그인을 하는 도중에 알 수 없는 에러가 발생했습니다.")
                }
                self?._isLoading.send(false)
            }, receiveValue: { [weak self] authentication in
                if authentication.accessToken != nil {
                    self?._isSuccessLogin.send(true)
                }
            }).store(in: &cancellables)
    }
    
    func didTapKakaoButton() {
        _isLoading.send(true)
        authRepository.kakaoAuthorize()
            .compactMap { $0 }
            .sink(receiveCompletion: { [weak self] complection in
                if case let .failure(error) = complection {
                    debugPrint(error)
                    self?._errorMessage.send("로그인을 하는 도중에 알 수 없는 에러가 발생했습니다.")
                }
                self?._isLoading.send(false)
            }, receiveValue: { [weak self] authentication in
                self?.successLogin(authentication, snsType: .kakao)
            }).store(in: &cancellables)
    }
    
    func didTapAppleButton() {
        _isLoading.send(true)
        authRepository.appleAuthorize()
            .compactMap { $0 }
            .sink(receiveCompletion: { [weak self] complection in
                if case let .failure(error) = complection {
                    debugPrint(error)
                    self?._errorMessage.send("로그인을 하는 도중에 알 수 없는 에러가 발생했습니다.")
                }
                self?._isLoading.send(false)
            }, receiveValue: { [weak self] authentication in
                self?.successLogin(authentication, snsType: .apple)
            }).store(in: &cancellables)
    }
    
    func didTapFacebookButton() {
        _isLoading.send(true)
        authRepository.facebookAuthorize()
            .compactMap { $0 }
            .sink(receiveCompletion: { [weak self] complection in
                if case let .failure(error) = complection {
                    debugPrint(error)
                    self?._errorMessage.send("로그인을 하는 도중에 알 수 없는 에러가 발생했습니다.")
                }
                self?._isLoading.send(false)
            }, receiveValue: { [weak self] authentication in
                self?.successLogin(authentication, snsType: .facebook)
            }).store(in: &cancellables)
    }
}

extension DefaultAuthViewModel: AuthViewModelOutput {
    
    var output: AuthViewModelOutput { self }
    
    var errorMessage: AnyPublisher<String?, Never> { _errorMessage.eraseToAnyPublisher() }
    var appleAuthorizationController: ASAuthorizationController { authRepository.appleAuthorizationController() }
    var isLoading: AnyPublisher<Bool, Never> { _isLoading.eraseToAnyPublisher() }
    var isCompletedLogin: AnyPublisher<Bool, Never> { _isSuccessLogin.eraseToAnyPublisher() }
    
}
