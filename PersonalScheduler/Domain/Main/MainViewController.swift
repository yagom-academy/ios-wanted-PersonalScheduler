//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit

class MainViewController: UIViewController {
    
    private enum Constant {
        static var kakaobutton = "kakao_button_large"
    }

    private var mainViewModel: MainViewModelable
    
    init(mainViewModel: MainViewModelable) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupView()
    }
    
    private func bind() {
        mainViewModel.userId.observe(on: self) { userId in
            guard let userId = userId else {
                return
            }
            //다음화면으로 전환
        }
        mainViewModel.errorMessage.observe(on: self) { [weak self] errorMessage in
            guard let errorMessage = errorMessage else {
                return
            }
            self?.showErrorAlert(message: errorMessage)
        }
    }
    
    // MARK - View
    
    private lazy var AppTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 2
        label.text = """
                    PersonalScheduler
                    개인 스케줄 관리앱
                    """
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    private lazy var kakaobutton: UIButton = {
        let button = UIButton(frame: .zero)
        let image = UIImage(named: Constant.kakaobutton)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(kakoLogin(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func kakoLogin(_ sender: UIButton) {
        mainViewModel.login(loginType: .kakao)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubviews(AppTitle)
        NSLayoutConstraint.activate([
            AppTitle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            AppTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            AppTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        view.addSubviews(kakaobutton)
        NSLayoutConstraint.activate([
            kakaobutton.topAnchor.constraint(equalTo: AppTitle.bottomAnchor, constant: 150),
            kakaobutton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            kakaobutton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            kakaobutton.heightAnchor.constraint(equalTo: kakaobutton.widthAnchor, multiplier: 0.2)
        ])
    }
}

