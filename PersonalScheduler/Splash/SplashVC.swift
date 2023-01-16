//
//  SplashVC.swift
//  PersonalScheduler
//
//  Created by 정재근 on 09/01/23.
//

import UIKit

class SplashVC: BaseVC {
    // MARK: - Properties
    private let viewModel = SplashVM()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        outputBind()
        viewModel.input.viewDidLoadTrigger.value = ()
    }
}
// MARK: - bind
extension SplashVC {
    
    private func outputBind() {
        viewModel.output.splashResult.bind { [weak self] splashResult in
            switch splashResult {
            case .registered:
                self?.navigationController?.pushViewController(ScheduleListVC(), animated: true)
            case .notRegistered:
                self?.navigationController?.pushViewController(LoginVC(), animated: true)
            }
        }
    }
}

