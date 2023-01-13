//
//  BaseViewController.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/11.
//

import UIKit

open class BaseViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        addView()
        setupView()
        setLayout()
        
        bindViewModel()
    }
    
    open func addView() { }
    
    open func setupView() { }
    
    open func setLayout() { }
    
    open func bindViewModel() { }
}
