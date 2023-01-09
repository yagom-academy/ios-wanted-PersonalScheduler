//
//  ViewModel.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
