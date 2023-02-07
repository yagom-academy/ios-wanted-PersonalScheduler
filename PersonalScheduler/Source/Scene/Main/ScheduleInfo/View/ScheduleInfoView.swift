//
//  ScheduleInfoView.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

class ScheduleInfoView: UIView {
    let mode: ManageMode = .create
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
