//
//  BaseVC.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    func isHiddenBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func isLargeTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
}
