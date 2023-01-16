//
//  LoginVC.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit
import KakaoSDKAuth

class LoginVC: BaseVC {
    // MARK: - View
    private let loginView = LoginV()
    
    override func loadView() {
        self.view = loginView
    }
    // MARK: - ViewModel
    private let viewModel = LoginVM()
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        isHiddenBackButton()
        addButtonAction()
        outputBind()
    }
}
// MARK: - addButtonAction
extension LoginVC {
    
    private func addButtonAction() {
        self.loginView.kakaoLoginButton.addTarget(self, action: #selector(didTapLoginButton(_ :)), for: .touchUpInside)
    }
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
        self.loginView.indicator.startAnimating()
        switch sender {
        case loginView.kakaoLoginButton :
            self.viewModel.input.loginTrigger.value = .kakao
        default :
            print("오류")
        }
    }
}

// MARK: - OuputBind
extension LoginVC {
    
    private func outputBind() {
        self.viewModel.output.isLoginable.bind { [weak self] error in
            self?.loginView.indicator.stopAnimating()
            if let error {
                AlertManager.shared.showErrorAlert(error: error, viewController: self!)
            } else {
                self?.navigationController?.pushViewController(ScheduleListVC(), animated: true)
            }
        }
    }
}
