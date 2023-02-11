//  PersonalScheduler - BaseViewController.swift
//  Created by zhilly on 2023/02/08

import UIKit

open class BaseViewController: UIViewController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        bindViewModel()
    }
    
    open func setupView() {
        view.backgroundColor = UIColor(named: "AppColor")
    }
    
    open func setupLayout() { }
    
    open func bindViewModel() { }
}

